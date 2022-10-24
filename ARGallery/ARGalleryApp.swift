//
//  ARGalleryApp.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

@main
struct ARGalleryApp: App {
  @StateObject var placementSettings: PlacementSettings = .init()
  @StateObject var sessionSettings: SessionSettings = .init()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(placementSettings)
        .environmentObject(sessionSettings)
    }
  }
}
