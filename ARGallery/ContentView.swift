//
//  ContentView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var placementSettings: PlacementSettings
  
  @State private var isControlsVisible = true
  @State private var isBrowseViewPresented = false
  @State private var isSettingsSheetPresented = false
  
  var body: some View {
    content
      .sheet(isPresented: $isBrowseViewPresented) {
        BrowseSheet(isBrowseSheetPresented: $isBrowseViewPresented)
      }
      .sheet(isPresented: $isSettingsSheetPresented) {
        SettingsSheet(isSettingsSheetPresented: $isSettingsSheetPresented)
      }
  }
  
  var content: some View {
    ZStack(alignment: .bottom) {
      ARViewContainer()
      
      if placementSettings.selectedModel == nil {
        ControlView(
          isControlsVisible: $isControlsVisible,
          isBrowseViewPresented: $isBrowseViewPresented,
          isSettingsSheetPresented: $isSettingsSheetPresented
        )
        .padding(.bottom)
      } else {
        PlacementView()
      }
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(PlacementSettings())
      .environmentObject(SessionSettings())
  }
}
