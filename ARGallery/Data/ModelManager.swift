//
//  ModelManager.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import FirebaseFirestore
import Foundation

final class ModelManager: ObservableObject {
  @Published var models: [Model] = []
  
  private let db = Firestore.firestore()
  
  func fetchData() {
    db.collection("models").addSnapshotListener { querySnapshot, error in
      guard let documents = querySnapshot?.documents else {
        print("Firestore: No documents.")
        return
      }
      
      self.models = documents.map { (queryDocumentSnapshot) -> Model in
        let data = queryDocumentSnapshot.data()
        
        let name = data["name"] as? String ?? ""
        let categoryText = data["category"] as? String ?? ""
        let category = ModelCategory(rawValue: categoryText) ?? .misc
        let scaleCompensation = data["scaleCompensation"] as? Double ?? 1.0
        
        return Model(name: name, category: category, scaleCompensation: Float(scaleCompensation))
      }
    }
  }
  
  func clearModelEntitiesFromMemory() {
    for model in models {
      model.modelEntity = nil
    }
  }
}
