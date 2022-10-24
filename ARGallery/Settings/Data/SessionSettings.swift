//
//  SessionSettings.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import SwiftUI

final class SessionSettings: ObservableObject {
  @Published var isPeopleOcclusionEnabled = false
  @Published var isObjectOcclusionEnabled = false
  @Published var isLidarDebugEnabled = false
  @Published var isMultiuserEnabled = false
}
