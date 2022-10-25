//
//  ModelButtonView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

struct ModelButtonView: View {
  @ObservedObject var model: Model
  
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Image(uiImage: model.thumbnail)
        .resizable()
        .frame(height: 150)
        .aspectRatio(1/1, contentMode: .fit)
        .background(Color(uiColor: UIColor.secondarySystemFill))
        .cornerRadius(8)
    }
  }
}

//struct ModelButtonView_Previews: PreviewProvider {
//  static var previews: some View {
//    ModelButtonView(model: Model.all.first!, action: {})
//  }
//}
