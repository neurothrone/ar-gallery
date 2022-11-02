//
//  ARViewContainer.swift
//  ARFurniture
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import ARKit
import RealityKit
import SwiftUI

private let anchorNamePrefix = "model-"

struct ARViewContainer: UIViewRepresentable {
  @EnvironmentObject var placementSettings: PlacementSettings
  @EnvironmentObject var sessionSettings: SessionSettings
  @EnvironmentObject var sceneManager: SceneManager
  @EnvironmentObject var modelManager: ModelManager
  @EnvironmentObject var modelDeletionManager: ModelDeletionManager
  
  func makeUIView(context: Context) -> CustomARView {
    let arView = CustomARView(
      frame: .zero,
      sessionSettings: sessionSettings,
      modelDeletionManager: modelDeletionManager
    )
    arView.session.delegate = context.coordinator
    
    placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
      updateScene(for: arView)
      updatePersistenceAvailability(for: arView)
      handlePersistence(for: arView)
    }
    
    return arView
  }
  
  func updateUIView(_ uiView: CustomARView, context: Context) {}
  
  private func updateScene(for arView: CustomARView) {
    // Only display focusEntity when the user has selected a model for placement
    arView.focusEntity?.isEnabled = placementSettings.selectedModel != nil
    
    // Add model(s) to scene if confirmed for placement
    if let modelAnchor = placementSettings.modelsConfirmedForPlacement.popLast(), let modelEntity = modelAnchor.model.modelEntity {
      
      if let anchor = modelAnchor.anchor {
        // Anchor is being loaded from persisted scene
        place(modelEntity, for: anchor, in: arView)
      } else if let transform = getTransformForPlacement(in: arView) {
        // Anchor needs to be created for placement
        let anchorName = anchorNamePrefix + modelAnchor.model.name
        let anchor = ARAnchor(name: anchorName, transform: transform)
        
        place(modelEntity, for: anchor, in: arView)
        
        arView.session.add(anchor: anchor)
        placementSettings.recentlyPlaced.append(modelAnchor.model)
      }
    }
  }
  
  private func place(_ modelEntity: ModelEntity, for anchor: ARAnchor, in arView: ARView) {
    // 1. Clone modelEntity. This created an identical copy of modelEntity and references the same model. This also allows us to have multiple models of the same asset in our scene.
    let clonedEntity = modelEntity.clone(recursive: true)
    
    // 2. Enable translation and rotation gestures.
    clonedEntity.generateCollisionShapes(recursive: true)
    arView.installGestures([.translation, .rotation], for: clonedEntity)
    
    // 3. Create an anchorEntity and add clonedEntity to the anchorEntity
    let anchorEntity = AnchorEntity(plane: .any)
    anchorEntity.addChild(clonedEntity)
    
    anchorEntity.anchoring = AnchoringComponent(anchor)
    
    // 4. Add the anchorEntity to the arView.scene
    arView.scene.addAnchor(anchorEntity)
    
    sceneManager.anchorEntities.append(anchorEntity)
    
    print("Added modelEntity to scene")
  }
  
  private func getTransformForPlacement(in arView: ARView) -> simd_float4x4? {
    guard let query = arView.makeRaycastQuery(from: arView.center, allowing: .estimatedPlane, alignment: .any) else {
      return nil
    }
    
    guard let raycastResult = arView.session.raycast(query).first else { return nil }
    
    return raycastResult.worldTransform
  }
}

// MARK: - Persistence
final class SceneManager: ObservableObject {
  @Published var isPersistenceAvailable = false
  @Published var anchorEntities: [AnchorEntity] = [] // Tracks anchor entities with model entities in the scene
  
  var shouldSaveSceneToFilesystem: Bool = false // Flag to trigger save scene to filesystem function
  var shouldLoadSceneFromFilesystem: Bool = false // Flag to trigger load scene from filesystem function
  
  lazy var persistenceURL: URL = {
    do {
      return try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
      )
      .appending(path: "arf.persistence")
    } catch {
      fatalError("❌ -> Unable to get persistenceURL. Error: \(error.localizedDescription)")
    }
  }()
  
  var scenePersistenceData: Data? {
    try? Data(contentsOf: persistenceURL)
  }
}

extension ARViewContainer {
  private func updatePersistenceAvailability(for arView: ARView) {
    guard let currentFrame = arView.session.currentFrame else {
      print("❌ -> ARFrame not available.")
      return
    }
    
    switch currentFrame.worldMappingStatus {
    case .mapped, .extending:
      sceneManager.isPersistenceAvailable = !sceneManager.anchorEntities.isEmpty
    default:
      sceneManager.isPersistenceAvailable = false
    }
  }
  
  private func handlePersistence(for arView: CustomARView) {
    if sceneManager.shouldSaveSceneToFilesystem {
      ScenePersistenceHelper.saveScene(for: arView, at: sceneManager.persistenceURL)
      sceneManager.shouldSaveSceneToFilesystem = false
    } else if sceneManager.shouldLoadSceneFromFilesystem {
      guard let scenePersistenceData = sceneManager.scenePersistenceData else {
        print("Unable to retrieve scenePersistenceData. Canceled loadScene operation.")
        
        sceneManager.shouldLoadSceneFromFilesystem = false
        return
      }
      
      modelManager.clearModelEntitiesFromMemory()
      sceneManager.anchorEntities.removeAll(keepingCapacity: true)
      
      ScenePersistenceHelper.loadScene(for: arView, with: scenePersistenceData)
      sceneManager.shouldLoadSceneFromFilesystem = false
    }
  }
}

//MARK: - ARSessionDelegate + Coordinator

extension ARViewContainer {
  final class Coordinator: NSObject, ARSessionDelegate {
    var parent: ARViewContainer
    
    init(_ parent: ARViewContainer) {
      self.parent = parent
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
      for anchor in anchors {
        if let anchorName = anchor.name, anchorName.hasPrefix(anchorNamePrefix) {
          let modelname = anchorName.dropFirst(anchorNamePrefix.count)
          
          print("ARSession: didAdd anchor for modelName: \(modelname)")
          
          guard let model = parent.modelManager.models.first(where: { $0.name == modelname }) else {
            print("Unable to retrieve model from ModelManager.")
            return
          }
          
          if model.modelEntity == nil {
            model.asyncLoadModelEntity { completed, error in
              if completed {
                let modelAnchor = ModelAnchor(model: model, anchor: anchor)
                self.parent.placementSettings.modelsConfirmedForPlacement.append(modelAnchor)
                print("Adding modelAnchor with name: \(model.name)")
              }
            }
          }
        }
      }
    }
  }
  
  func makeCoordinator() -> Coordinator {
    .init(self)
  }
}
