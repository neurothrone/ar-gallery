//
//  ARViewContainer.swift
//  ARFurniture
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
  @EnvironmentObject var placementSettings: PlacementSettings
  @EnvironmentObject var sessionSettings: SessionSettings
  
  func makeUIView(context: Context) -> CustomARView {
    let arView = CustomARView(frame: .zero, sessionSettings: sessionSettings)
    
    placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
      updateScene(for: arView)
    }
    
    return arView
  }
  
  func updateUIView(_ uiView: CustomARView, context: Context) {
    
  }
  
  private func updateScene(for arView: CustomARView) {
    // Only display focusEntity when the user has selected a model for placement
    arView.focusEntity?.isEnabled = placementSettings.selectedModel != nil
    
    // Add model to scene if confirmed for placement
    guard let confirmedModel = placementSettings.confirmedModel,
       let modelEntity = confirmedModel.modelEntity else {
      return
    }
    
    place(modelEntity, in: arView)
    placementSettings.confirmedModel = nil
  }
  
  private func place(_ modelEntity: ModelEntity, in arView: ARView) {
    // 1. Clone modelEntity. This created an identical copy of modelEntity and references the same model. This also allows us to have multiple models of the same asset in our scene.
    let clonedEntity = modelEntity.clone(recursive: true)
    
    // 2. Enable translation and rotation gestures.
    clonedEntity.generateCollisionShapes(recursive: true)
    arView.installGestures([.translation, .rotation], for: clonedEntity)
    
    // 3. Create an anchorEntity and add clonedEntity to the anchorEntity
    let anchorEntity = AnchorEntity(plane: .any)
    anchorEntity.addChild(clonedEntity)
    
    // 4. Add the anchorEntity to the arView.scene
    arView.scene.addAnchor(anchorEntity)
    
    print("Added modelEntity to scene")
  }
}
