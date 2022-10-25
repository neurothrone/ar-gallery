//
//  FirebaseStorageHelper.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-25.
//

import FirebaseStorage
import Foundation

final class FirebaseStorageHelper {
  static private let cloudStorage = Storage.storage()
  
  class func asyncDownloadToFilesystem(
    relativePath: String,
    handler: @escaping (_ fileURL: URL) -> Void
  ) {
    // Create local filesystem URL
    let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // Relative paths:
    // thumbnails/model_name.png
    // models/model_name.usdz
    let fileURL = docsURL.appendingPathComponent(relativePath)
    
    // Check if asset is already in the local filesystem
    // If it is, load that asset and return
    if FileManager.default.fileExists(atPath: fileURL.path()) {
      handler(fileURL)
      return
    }
    
    // Create a reference to the asset
    let storageRef = cloudStorage.reference(withPath: relativePath)
    
    // Download to the local filesystem
    storageRef.write(toFile: fileURL) { url, error in
      guard let localURL = url else {
        print("❌ -> Firebase Storage: Error downloading file with relativePath: \(relativePath)")
        return
      }
      
      handler(localURL)
    }
    .resume()
  }
}
