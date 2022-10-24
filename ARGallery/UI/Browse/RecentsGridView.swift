//
//  RecentsGridView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct RecentsGridView: View {
  @EnvironmentObject var placementSettings: PlacementSettings
  
  @Binding var isBrowseSheetPresented: Bool
  
  var body: some View {
    if !placementSettings.recentlyPlaced.isEmpty {
      HorizontalGridView(isBrowseSheetPresented: $isBrowseSheetPresented, title: "Recents", items: getRecentsUniqueOrdered()
      )
    }
  }
  
  func getRecentsUniqueOrdered() -> [Model] {
    var recentModelsInUniqueOrderedArray: [Model] = []
    var modelNameSet: Set<String> = []
    
    for model in placementSettings.recentlyPlaced.reversed() {
      if !modelNameSet.contains(model.name) {
        recentModelsInUniqueOrderedArray.append(model)
        modelNameSet.insert(model.name)
      }
    }
    
    return recentModelsInUniqueOrderedArray
  }
}

struct RecentsGridView_Previews: PreviewProvider {
  static var previews: some View {
    RecentsGridView(isBrowseSheetPresented: .constant(true))
      .environmentObject(PlacementSettings())
  }
}
