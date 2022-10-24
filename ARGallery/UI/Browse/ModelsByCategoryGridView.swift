//
//  ModelsByCategoryGridView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct ModelsByCategoryGridView: View {
  @Binding var isBrowseSheetPresented: Bool
  
  @ObservedObject private var modelManager: ModelManager = .init()
  
  var body: some View {
    VStack {
      ForEach(ModelCategory.allCases) { category in
        let modelsInCategory = modelManager.models.filter { $0.category == category }
        
        if !modelsInCategory.isEmpty {
          HorizontalGridView(
            isBrowseSheetPresented: $isBrowseSheetPresented,
            title: category.title,
            items: modelsInCategory
          )
        }
      }
    }
    .onAppear(perform: modelManager.fetchData)
  }
}

struct ModelsByCategoryGridView_Previews: PreviewProvider {
  static var previews: some View {
    ModelsByCategoryGridView(isBrowseSheetPresented: .constant(true))
  }
}
