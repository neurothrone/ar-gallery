//
//  ModelDeletionManager.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-11-02.
//

import RealityKit
import SwiftUI

final class ModelDeletionManager: ObservableObject {
  @Published var selectedEntityToDelete: ModelEntity? = nil {
    willSet(newValue) {
      if selectedEntityToDelete == nil, let newlySelectedModelEntity = newValue {
        // Selecting new value, no prior selection
        print("Selecting new selectedEntityToDelete, no prior selection.")
        
        // Highlight new selectedEntityToDelete
        let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)
        newlySelectedModelEntity.modelDebugOptions = component
      } else if let previouslySelectedModelEntity = selectedEntityToDelete,
                let newlySelectedModelEntity = newValue {
        // Selection new value, had a prior selection
        print("Selecting new selectedEntityToDelete, had a prior selection.")
        
        // Un-highlight previouslySelectedModelEntity
        previouslySelectedModelEntity.modelDebugOptions = nil
        
        // Highlight newlySelectedModelEntity
        let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)
        newlySelectedModelEntity.modelDebugOptions = component
      } else if newValue == nil {
        // Clearing selectedEntityToDelete
        print("Clearing selectedEntityToDelete.")
        
        selectedEntityToDelete?.modelDebugOptions = nil
      }
    }
  }
}

