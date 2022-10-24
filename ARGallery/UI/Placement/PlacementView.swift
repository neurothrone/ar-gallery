//
//  PlacementView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct PlacementView: View {
  @EnvironmentObject var placementSettings: PlacementSettings
  
  var body: some View {
    HStack {
      Spacer()
      
      PlacementButtonView(systemImageName: "xmark.circle.fill") {
        print("Cancel placement button pressed")
        placementSettings.selectedModel = nil
      }
      
      Spacer()
      
      PlacementButtonView(systemImageName: "checkmark.circle.fill") {
        print("Confirm Placement button pressed")
        placementSettings.confirmedModel = placementSettings.selectedModel
        placementSettings.selectedModel = nil
      }
      
      Spacer()
    }
    .padding(.bottom, 30)
  }
}

struct PlacementView_Previews: PreviewProvider {
  static var previews: some View {
    PlacementView()
      .environmentObject(PlacementSettings())
  }
}
