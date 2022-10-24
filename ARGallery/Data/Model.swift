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
  case clothing = "Clothing"
  case furniture = "Furniture"
  case kitchenware = "Kitchenware"
  case toys = "Toys"
  case misc = "Misc"
}

extension ModelCategory: Identifiable, CaseIterable {
  var id: Self { self }
}

final class Model {
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

extension Model {
  static var all: [Model] = {
    var models: [Model] = []
    
    let airForce = Model(name: "AirForce", category: .clothing)
    models += [airForce]
    
    let chairSwan = Model(name: "chair_swan", category: .furniture)
    models += [chairSwan]
    
    let cupSaucerSet = Model(name: "cup_saucer_set", category: .kitchenware)
    models += [cupSaucerSet]
    
    let fenderStratocast = Model(name: "fender_stratocaster", category: .misc)
    models += [fenderStratocast]
    
    return models
  }()
  
  static func allBy(category: ModelCategory) -> [Model] {
    all.filter { $0.category == category }
  }
}
