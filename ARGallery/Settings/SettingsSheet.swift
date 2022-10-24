//
//  SettingsSheet.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct SettingsSheet: View {
  @Binding var isSettingsSheetPresented: Bool
  
  var body: some View {
    NavigationStack {
      SettingsGridView()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .status) {
            Button(action: { isSettingsSheetPresented.toggle() }) {
              Text("Done")
                .bold()
            }
          }
        }
    }
  }
}

struct SettingsSheet_Previews: PreviewProvider {
  static var previews: some View {
    SettingsSheet(isSettingsSheetPresented: .constant(true))
  }
}
