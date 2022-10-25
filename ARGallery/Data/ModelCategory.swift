//
//  ModelCategory.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-25.
//

import Foundation

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
