//
//  MostRecentlyPlacedButtonView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct MostRecentlyPlacedButtonView: View {
  @EnvironmentObject var placementSettings: PlacementSettings
  
  var body: some View {
    Button {
      print("Most Recently placed button pressed")
      placementSettings.selectedModel = placementSettings.recentlyPlaced.last
    } label: {
      if let mostRecentlyPlacedModel = placementSettings.recentlyPlaced.last {
        Image(uiImage: mostRecentlyPlacedModel.thumbnail)
          .resizable()
          .frame(width: 46)
          .aspectRatio(1, contentMode: .fit)
      } else {
        Image(systemName: "clock.fill")
          .font(.title)
          .foregroundColor(.white)
          .buttonStyle(.plain)
      }
    }
    .frame(width: 50, height: 50)
    .background(.white)
    .cornerRadius(8)
  }
}

struct MostRecentlyPlacedButtonView_Previews: PreviewProvider {
  static var previews: some View {
    MostRecentlyPlacedButtonView()
      .environmentObject(PlacementSettings())
  }
}
