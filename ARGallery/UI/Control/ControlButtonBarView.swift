//
//  ControlButtonBarView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ControlButtonBarView: View {
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
    .frame(maxWidth: .infinity)
    .padding()
    .background(.purple.opacity(0.5))
  }
}

struct ControlButtonBarView_Previews: PreviewProvider {
  static var previews: some View {
    ControlButtonBarView(
      isBrowseViewPresented: .constant(false),
      isSettingsSheetPresented: .constant(false)
    )
    .environmentObject(PlacementSettings())
  }
}
