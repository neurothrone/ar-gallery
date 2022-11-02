//
//  DeletionView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-11-02.
//

import SwiftUI

struct DeletionButtonView: View {
  let systemImageName: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Image(systemName: systemImageName)
        .font(.system(.largeTitle, design: .default, weight: .light))
        .foregroundColor(.white)
        .buttonStyle(.plain)
    }
    .frame(width: 75, height: 75)
  }
}

struct DeletionView: View {
  @EnvironmentObject var sceneManager: SceneManager
  @EnvironmentObject var modelDeletionManager: ModelDeletionManager
  
  var body: some View {
    HStack {
      Spacer()
      
      DeletionButtonView(systemImageName: "xmark.circle.fill") {
        print("Cancel Deletion button pressed.")
        modelDeletionManager.selectedEntityToDelete = nil
      }
      
      Spacer()
      
      DeletionButtonView(systemImageName: "trash.circle.fill") {
        print("Confirm Deletion button pressed.")
        
        guard let anchor = modelDeletionManager.selectedEntityToDelete?.anchor else { return }
        
        let anchoringIdentifier = anchor.anchorIdentifier
        
        if let index = sceneManager.anchorEntities.firstIndex(where: { $0.anchorIdentifier == anchoringIdentifier }) {
          print("Deleting anchorEntity with id: \(String(describing: anchoringIdentifier))")
          sceneManager.anchorEntities.remove(at: index)
        }
        
        anchor.removeFromParent()
        modelDeletionManager.selectedEntityToDelete = nil
      }
      
      Spacer()
    }
    .padding(.bottom, 30)
  }
}

struct DeletionView_Previews: PreviewProvider {
  static var previews: some View {
    DeletionView()
      .environmentObject(SceneManager())
      .environmentObject(ModelDeletionManager())
  }
}
