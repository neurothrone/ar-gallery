//
//  ContentView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var placementSettings: PlacementSettings
  @EnvironmentObject var modelManager: ModelManager
  @EnvironmentObject var modelDeletionManager: ModelDeletionManager
  
  @State private var isControlsVisible = true
  @State private var isBrowseViewPresented = false
  @State private var isSettingsSheetPresented = false
  
  @State private var selectedControlMode: ControlMode = .browse
  
  var body: some View {
    content
      .sheet(isPresented: $isBrowseViewPresented) {
        BrowseSheet(isBrowseSheetPresented: $isBrowseViewPresented)
          .environmentObject(placementSettings)
      }
      .sheet(isPresented: $isSettingsSheetPresented) {
        SettingsSheet(isSettingsSheetPresented: $isSettingsSheetPresented)
      }
  }
  
  var content: some View {
    ZStack(alignment: .bottom) {
      ARViewContainer()
      
      if placementSettings.selectedModel != nil {
        PlacementView()
      } else if modelDeletionManager.selectedEntityToDelete != nil {
        DeletionView()
      } else {
        ControlView(
          isControlsVisible: $isControlsVisible,
          isBrowseViewPresented: $isBrowseViewPresented,
          isSettingsSheetPresented: $isSettingsSheetPresented, selectedControlMode: $selectedControlMode
        )
        .padding(.bottom)
      }
    }
    .edgesIgnoringSafeArea(.all)
    .onAppear(perform: modelManager.fetchData)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(PlacementSettings())
      .environmentObject(SessionSettings())
      .environmentObject(SceneManager())
      .environmentObject(ModelManager())
      .environmentObject(ModelDeletionManager())
  }
}
