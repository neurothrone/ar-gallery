//
//  Model.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-23.
//

import Combine
import RealityKit
import SwiftUI

final class Model: ObservableObject, Identifiable {
  @Published var thumbnail: UIImage
  
  var id: String = UUID().uuidString
  
  var name: String
  var category: ModelCategory
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
    self.thumbnail = UIImage(systemName: "photo")!
    self.scaleCompensation = scaleCompensation
    
    FirebaseStorageHelper.asyncDownloadToFilesystem(relativePath: "thumbnails/\(name).png") { localURL in
      do {
        let imageData = try Data(contentsOf: localURL)
        self.thumbnail = UIImage(data: imageData) ?? self.thumbnail
      } catch {
        print("❌ -> Failed to load thumbnail from firebase. Error: \(error)")
      }
    }
  }
  
  func asyncLoadModelEntity(
    handler: @escaping (_ completed: Bool, _ error: Error?) -> Void
  ) {
    FirebaseStorageHelper.asyncDownloadToFilesystem(relativePath: "models/\(name).usdz") { localURL in
      self.cancellable = ModelEntity.loadModelAsync(contentsOf: localURL)
        .sink { loadCompletion in
          switch loadCompletion {
          case .failure(let error):
            print("❌ -> Failed to load modelEntity for \(self.name) from Firebase. Error: \(error)")
            handler(false, error)
          case .finished:
            break
          }
        } receiveValue: { modelEntity in
          self.modelEntity = modelEntity
          self.modelEntity?.scale *= self.scaleCompensation
          
          handler(true, nil)
          
          print("modelEntity for \(self.name) has been loaded.")
        }
    }
  }
}
