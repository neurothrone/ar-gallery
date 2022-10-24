//
//  SettingsGridView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct SettingsGridView: View {
  @EnvironmentObject var sessionSettings: SessionSettings
  
  private var gridLayout = [
    GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridLayout, spacing: 25) {
        SettingToggleButtonView(
          isOn: $sessionSettings.isPeopleOcclusionEnabled,
          setting: .peopleOcclusion
        )
        
        SettingToggleButtonView(
          isOn: $sessionSettings.isObjectOcclusionEnabled,
          setting: .objectOcclusion
        )
        
        SettingToggleButtonView(
          isOn: $sessionSettings.isLidarDebugEnabled,
          setting: .lidarDebug
        )
        
        SettingToggleButtonView(
          isOn: $sessionSettings.isMultiuserEnabled,
          setting: .multiuser
        )
      }
    }
    .padding(.top, 35)
  }
}

struct SettingsGridView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsGridView()
      .environmentObject(SessionSettings())
  }
}
