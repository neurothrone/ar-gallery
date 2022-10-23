//
//  ControlButtonBarView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ControlButtonBarView: View {
  var body: some View {
    HStack {
      CustomButtonView(systemImageName: "clock.fill", action: {})
      Spacer()
      CustomButtonView(systemImageName: "square.grid.2x2", action: {})
      Spacer()
      CustomButtonView(systemImageName: "slider.horizontal.3", action: {})
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(.purple.opacity(0.5))
  }
}

struct ControlButtonBarView_Previews: PreviewProvider {
  static var previews: some View {
    ControlButtonBarView()
  }
}
