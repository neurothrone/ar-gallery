//
//  BrowseSheet.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import SwiftUI

struct BrowseSheet: View {
  @Binding var isBrowseSheetPresented: Bool
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        // Grid Views for thumbnails
        RecentsGridView(isBrowseSheetPresented: $isBrowseSheetPresented)
        ModelsByCategoryGridView(isBrowseSheetPresented: $isBrowseSheetPresented)
      }
      .navigationTitle("Browse")
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button {
            isBrowseSheetPresented = false
          } label: {
            Text("Done")
              .bold()
          }
        }
      }
    }
  }
}

struct BrowseSheet_Previews: PreviewProvider {
  static var previews: some View {
    BrowseSheet(isBrowseSheetPresented: .constant(true))
  }
}
