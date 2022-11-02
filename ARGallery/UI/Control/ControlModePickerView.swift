//
//  ControlModePickerView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-11-01.
//

import SwiftUI

struct ControlModePickerView: View {
  @Binding var selectedControlMode: ControlMode
  
  init(selectedControlMode: Binding<ControlMode>) {
    _selectedControlMode = selectedControlMode
    
    UISegmentedControl.appearance().selectedSegmentTintColor = .clear
    
    UISegmentedControl.appearance().setTitleTextAttributes(
      [
        .foregroundColor: UIColor(
          displayP3Red: 1.0,
          green: 0.827,
          blue: 0,
          alpha: 1
        )
      ],
      for: .selected
    )
    
    UISegmentedControl.appearance().setTitleTextAttributes(
      [
        .foregroundColor: UIColor.white
      ],
      for: .normal
    )
    
    UISegmentedControl.appearance().backgroundColor = UIColor(Color.black.opacity(0.25))
  }
  
  var body: some View {
    Picker(selection: $selectedControlMode) {
      ForEach(ControlMode.allCases) { controlMode in
        Button(action: { selectedControlMode = controlMode}) {
          Text(controlMode.rawValue.uppercased())
        }
      }
    } label: {
      Text("Select a Control Mode")
    }
    .pickerStyle(.segmented)
    .frame(maxWidth: 400)
    .padding(.horizontal, 10)
  }
}

struct ControlModePickerView_Previews: PreviewProvider {
  static var previews: some View {
    ControlModePickerView(selectedControlMode: .constant(.browse))
  }
}
