//
//  ControlButtonBarVisibilityToggleView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ControlButtonBarVisibilityToggleView: View {
  @Binding var isControlsVisible: Bool
  
  var body: some View {
    content
      .padding(.top, 45)
      .padding(.trailing, 20)
  }
  
  var content: some View {
    HStack {
      Spacer()
      
      ZStack {
        if isControlsVisible {
          Color.purple.opacity(0.25)
        } else {
          Color.gray.opacity(0.25)
        }
        
        button
      }
      .frame(width: 44, height: 44)
      .cornerRadius(8)
    }
  }
  
  var button: some View {
    Button {
      withAnimation(.linear) {
        isControlsVisible.toggle()
      }
    } label: {
      Image(
        systemName: isControlsVisible
        ? "rectangle"
        : "rectangle.slash"
      )
      .font(.title)
      .foregroundColor(isControlsVisible ? .purple : .white)
    }
    .buttonStyle(.plain)
  }
}

struct ControlButtonBarVisibilityToggleView_Previews: PreviewProvider {
  static var previews: some View {
    ControlButtonBarVisibilityToggleView(isControlsVisible: .constant(true))
  }
}
