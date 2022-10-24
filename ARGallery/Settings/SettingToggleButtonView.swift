//
//  SettingToggleButtonView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct SettingToggleButtonView: View {
  @Binding var isOn: Bool
  
  let setting: Setting
  
  var body: some View {
    Button {
      isOn.toggle()
      print("\(#file) - \(setting): \(isOn)")
    } label: {
      VStack {
        Image(systemName: setting.systemImageName)
          .font(.title)
          .foregroundColor(isOn ? .purple : Color(UIColor.secondaryLabel))
          .buttonStyle(.plain)
        
        Text(setting.title)
          .font(.system(.headline, design: .default, weight: .medium))
          .foregroundColor(
            isOn
            ? Color(UIColor.label)
            : Color(UIColor.secondaryLabel)
          )
          .padding(.top, 5)
      }
    }
    .frame(width: 100, height: 100)
    .background(Color(UIColor.secondarySystemFill))
    .cornerRadius(20)
  }
}

struct SettingToggleButtonView_Previews: PreviewProvider {
  static var previews: some View {
    SettingToggleButtonView(isOn: .constant(true), setting: .peopleOcclusion)
  }
}
