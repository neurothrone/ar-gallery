//
//  PlacementButtonView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct PlacementButtonView: View {
  let systemImageName: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Image(systemName: systemImageName)
        .font(.system(.largeTitle, design: .default, weight: .light))
        .foregroundColor(.white)
        .buttonStyle(.plain)
    }
    .frame(width: 75, height: 75)
  }
}

struct PlacementButtonView_Previews: PreviewProvider {
  static var previews: some View {
    PlacementButtonView(systemImageName: "checkmark.circle.fill", action: {})
  }
}
