//
//  ControlView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

enum ControlMode: String, Identifiable, CaseIterable {
  case browse, scene
  
  var id: Self { self }
}

struct ControlView: View {
  @Binding var isControlsVisible: Bool
  @Binding var isBrowseViewPresented: Bool
  @Binding var isSettingsSheetPresented: Bool
  @Binding var selectedControlMode: ControlMode
  
  var body: some View {
    VStack {
      ControlButtonBarVisibilityToggleView(isControlsVisible: $isControlsVisible)
      Spacer()
      
      if isControlsVisible {
        ControlModePickerView(selectedControlMode: $selectedControlMode)
        ControlButtonBarView(
          isBrowseViewPresented: $isBrowseViewPresented,
          isSettingsSheetPresented: $isSettingsSheetPresented,
          selectedControlMode: $selectedControlMode
        )
      }
    }
  }
}

struct ControlView_Previews: PreviewProvider {
  static var previews: some View {
    ControlView(
      isControlsVisible: .constant(true),
      isBrowseViewPresented: .constant(false),
      isSettingsSheetPresented: .constant(false),
      selectedControlMode: .constant(.browse)
    )
  }
}
