//
//  ContentView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ContentView: View {
  @State private var isControlsVisible = true
  @State private var isBrowseViewPresented = true
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ARViewContainer()
      ControlView(isControlsVisible: $isControlsVisible)
        .padding(.bottom)
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
