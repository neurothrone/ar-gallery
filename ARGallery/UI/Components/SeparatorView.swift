//
//  SeparatorView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct SeparatorView: View {
  var body: some View {
    Divider()
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
  }
}

struct SeparatorView_Previews: PreviewProvider {
  static var previews: some View {
    SeparatorView()
  }
}
