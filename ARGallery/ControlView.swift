//
//  ControlView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ControlView: View {
  @Binding var isControlsVisible: Bool
  
  var body: some View {
    VStack {
      ControlButtonBarVisibilityToggleView(isControlsVisible: $isControlsVisible)
      Spacer()
      
      if isControlsVisible {
        ControlButtonBarView()
      }
    }
  }
}

struct ControlView_Previews: PreviewProvider {
  static var previews: some View {
    ControlView(isControlsVisible: .constant(true))
  }
}
