//
//  ControlButtonBarView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ControlButtonBarView: View {
  @Binding var isBrowseViewPresented: Bool
  @Binding var isSettingsSheetPresented: Bool
  @Binding var selectedControlMode: ControlMode
  
  var body: some View {
    HStack(alignment: .center) {
      if selectedControlMode == .browse {
        BrowseButtons(
          isBrowseViewPresented: $isBrowseViewPresented,
          isSettingsSheetPresented: $isSettingsSheetPresented
        )
      } else {
        SceneButtons()
      }
    }
    .frame(maxWidth: 500)
    .padding(30)
    .background(.purple.opacity(0.25))
  }
}

struct BrowseButtons: View {
  @EnvironmentObject var placementSettings: PlacementSettings
  
  @Binding var isBrowseViewPresented: Bool
  @Binding var isSettingsSheetPresented: Bool
  
  var body: some View {
    HStack {
      
      // Most Recent Button
      MostRecentlyPlacedButtonView()
        .hidden(placementSettings.recentlyPlaced.isEmpty)
      
      Spacer()
      
      // Browse Button
      CustomButtonView(systemImageName: "square.grid.2x2") {
        isBrowseViewPresented.toggle()
      }
      
      Spacer()
      
      // Settings Button
      CustomButtonView(systemImageName: "slider.horizontal.3") {
        isSettingsSheetPresented.toggle()
      }
    }
  }
}

struct SceneButtons: View {
  @EnvironmentObject private var sceneManager: SceneManager
  
  var body: some View {
    CustomButtonView(systemImageName: "icloud.and.arrow.up") {
      print("Save Scene button pressed.")
      sceneManager.shouldSaveSceneToFilesystem = true
    }
    .hidden(!sceneManager.isPersistenceAvailable)
    
    Spacer()
    
    CustomButtonView(systemImageName: "icloud.and.arrow.down") {
      print("Load Scene button pressed.")
      sceneManager.shouldLoadSceneFromFilesystem = true
    }
    .hidden(sceneManager.scenePersistenceData == nil)
    
    Spacer()
    
    CustomButtonView(systemImageName: "trash") {
      print("Clear Scene button pressed")
      
      for anchorEntity in sceneManager.anchorEntities {
        print("Removing anchorEntity with id: \(String(describing: anchorEntity.anchorIdentifier))")
        anchorEntity.removeFromParent()
      }
    }
  }
}

struct ControlButtonBarView_Previews: PreviewProvider {
  static var previews: some View {
    ControlButtonBarView(
      isBrowseViewPresented: .constant(false),
      isSettingsSheetPresented: .constant(false),
      selectedControlMode: .constant(.browse)
    )
    .environmentObject(PlacementSettings())
  }
}
