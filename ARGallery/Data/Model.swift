//
//  Model.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import Combine
import RealityKit
import SwiftUI

enum ModelCategory: String {
  case clothing
  case furniture
  case kitchenware
  case toys
  case misc
  
  var title: String {
    switch self {
    case .clothing:
      return "Clothng"
    case .furniture:
      return "Furniture"
    case .kitchenware:
      return "Kitchenware"
    case .toys:
      return "Toys"
    case .misc:
      return "Misc"
    }
  }
}

extension ModelCategory: Identifiable, CaseIterable {
  var id: Self { self }
}

final class Model: Identifiable {
  var id: String = UUID().uuidString
  
  var name: String
  var category: ModelCategory
  var thumbnail: UIImage
  var modelEntity: ModelEntity?
  var scaleCompensation: Float
  
  private var cancellable: AnyCancellable?
  
  init(
    name: String,
    category: ModelCategory,
    scaleCompensation: Float = 1.0
  ) {
    self.name = name
    self.category = category
    self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
    self.scaleCompensation = scaleCompensation
  }
  
  func asyncLoadModelEntity() {
    let fileName = name + ".usdz"
    
    cancellable = ModelEntity.loadModelAsync(named: fileName)
      .sink { loadCompletion in
        switch loadCompletion {
        case .failure(let error):
          print("❌ -> Failed to load modelEntity for \(fileName). Error: \(error)")
        case .finished:
          break
        }
      } receiveValue: { modelEntity in
        self.modelEntity = modelEntity
        self.modelEntity?.scale *= self.scaleCompensation
        
        print("modelEntity for \(self.name) has been loaded.")
      }

  }
}
