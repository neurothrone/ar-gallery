//
//  ModelsByCategoryGridView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ModelsByCategoryGridView: View {
  @Binding var isBrowseSheetPresented: Bool
  
  let models: [Model] = Model.all
  
  var body: some View {
    VStack {
      ForEach(ModelCategory.allCases) { category in
        let modelsInCategory = Model.allBy(category: category)
        
        if !modelsInCategory.isEmpty {
          HorizontalGridView(
            isBrowseSheetPresented: $isBrowseSheetPresented,
            title: category.rawValue,
            items: modelsInCategory
          )
        }
      }
    }
  }
}

struct ModelsByCategoryGridView_Previews: PreviewProvider {
  static var previews: some View {
    ModelsByCategoryGridView(isBrowseSheetPresented: .constant(true))
  }
}
