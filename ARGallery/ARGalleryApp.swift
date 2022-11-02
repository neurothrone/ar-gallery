//
//  ARGalleryApp.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import Firebase
import SwiftUI

@main
struct ARGalleryApp: App {
  @StateObject var placementSettings: PlacementSettings = .init()
  @StateObject var sessionSettings: SessionSettings = .init()
  @StateObject var sceneManager: SceneManager = .init()
  @StateObject var modelManager: ModelManager = .init()
  @StateObject var modelDeletionManager: ModelDeletionManager = .init()
  
  init() {
    FirebaseApp.configure()
    
    // Anonymous authentication with Firebase
    Auth.auth().signInAnonymously { authResult, error in
      guard let user = authResult?.user else {
        print("FAILED: Anonymous Authentication with Firebase")
        return
      }
      
      print("Firebase: Anonymous user authentication with uid: \(user.uid)")
    }
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(placementSettings)
        .environmentObject(sessionSettings)
        .environmentObject(sceneManager)
        .environmentObject(modelManager)
        .environmentObject(modelDeletionManager)
    }
  }
}
