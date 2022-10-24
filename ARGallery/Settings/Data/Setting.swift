//
//  Setting.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

enum Setting {
  case peopleOcclusion
  case objectOcclusion
  case lidarDebug
  case multiuser
  
  var title: String {
    switch self {
    case .peopleOcclusion, .objectOcclusion:
      return "Occlusion"
    case .lidarDebug:
      return "LiDAR"
    case .multiuser:
      return "Multiuser"
    }
  }
  
  var systemImageName: String {
    switch self {
    case .peopleOcclusion:
      return "person"
    case .objectOcclusion:
      return "cube.box.fill"
    case .lidarDebug:
      return "light.min"
    case .multiuser:
      return "person.2"
    }
  }
}
