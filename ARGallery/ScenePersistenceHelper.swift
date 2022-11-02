//
//  ScenePersistenceHelper.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-11-01.
//

import ARKit
import RealityKit

final class ScenePersistenceHelper {
  class func saveScene(for arView: CustomARView, at persistenceURL: URL) {
    print("Save scene to local filesystem.")
    
    // 1. Get current worldMap from arView.session
    arView.session.getCurrentWorldMap { worldMap, error in
      // 2. Safely unwrap worldMap
      // CHALLENGE: Find a better view to alert the user if it fails
      guard let worldMap = worldMap else {
        print("Persistence Error: Unable to get worldMap: \(error!.localizedDescription)")
        return
      }
      
      // 3. Archive data and write to filesystem
      do {
        let sceneData = try NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true)
        try sceneData.write(to: persistenceURL, options: [.atomic])
      } catch {
        print("Persistence Error: Can't save scene to local filesystem: \(error.localizedDescription)")
      }
    }
  }
  
  class func loadScene(for arView: CustomARView, with scenePersistenceData: Data) {
    print("Load scene from local filesystem.")
    
    // 1. Unarchive the scenePersistenceData and retrieve ARWorldMap
    let worldMap: ARWorldMap = {
      do {
        guard let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: scenePersistenceData) else {
          fatalError("Persistence Error: No ARWorldMap in archive.")
        }
        
        return worldMap
      } catch {
        fatalError("Persistence Error: Unable to unarchive ARWorldMap from scenePersistenceData: \(error.localizedDescription)")
      }
    }()
    
    // 2. Reset configuration and load worldMap as initialWorldMap
    let newConfig = arView.defaultConfiguration
    newConfig.initialWorldMap = worldMap
    arView.session.run(newConfig, options: [.resetTracking, .removeExistingAnchors])
  }
}
