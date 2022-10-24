//
//  CustomButtonView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct CustomButtonView: View {
  let systemImageName: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Image(systemName: systemImageName)
        .font(.title)
        .foregroundColor(.white)
    }
    .buttonStyle(.plain)
    .frame(width: 44, height: 44)
  }
}

struct CustomButtonView_Previews: PreviewProvider {
  static var previews: some View {
    CustomButtonView(systemImageName: "square.grid.2x2", action: {})
      .preferredColorScheme(.dark)
  }
}
