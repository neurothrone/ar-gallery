//
//  ARViewContainer.swift
//  ARFurniture
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
  func makeUIView(context: Context) -> ARView {
    let view = ARView(frame: .zero)
    return view
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {}
}
