//
//  HorizontalGridView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct HorizontalGridView: View {
  @Binding var isBrowseSheetPresented: Bool
  
  @EnvironmentObject var placementSettings: PlacementSettings
  
  let title: String
  let items: [Model]
  
  private let gridLayout = [GridItem(.flexible(minimum: 120, maximum: 150))]
  
  var body: some View {
    VStack(alignment: .leading) {
      SeparatorView()
      
      Text(title)
        .font(.title2).bold()
        .padding(.leading, 22)
        .padding(.top, 10)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: gridLayout, spacing: 30) {
          ForEach(items) { model in
            ModelButtonView(model: model) {
              model.asyncLoadModelEntity()
              placementSettings.selectedModel = model
              isBrowseSheetPresented = false
            }
          }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
      }
    }
  }
}

//struct HorizontalGridView_Previews: PreviewProvider {
//  static var previews: some View {
//    HorizontalGridView(
//      isBrowseSheetPresented: .constant(true),
//      title: "Misc",
//      items: Model.allBy(category: .misc)
//    )
//    .environmentObject(PlacementSettings())
//  }
//}
