//
//  View+Extensions.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

extension View {
  @ViewBuilder
  func hidden(_ shouldHide: Bool) -> some View {
    if shouldHide {
      self.hidden()
    } else {
      self
    }
  }
}
