//
//  CustomARView.swift
//  ARGallery
//
//  Created by Zaid Neurothrone on 2022-10-24.
//

import ARKit
import Combine
import FocusEntity
import RealityKit
import SwiftUI


final class CustomARView: ARView {
  var focusEntity: FocusEntity?
  var sessionSettings: SessionSettings
  
  private var peopleOcclusionCancellable: AnyCancellable?
  private var objectOcclusionCancellable: AnyCancellable?
  private var lidarDebugCancellable: AnyCancellable?
  private var multiuserCancellable: AnyCancellable?
  
  private var cancellables: Set<AnyCancellable> = []
  
  required init(frame frameRect: CGRect, sessionSettings: SessionSettings) {
    self.sessionSettings = sessionSettings
    
    super.init(frame: frameRect)
    
    focusEntity = FocusEntity(on: self, focus: .classic)
    
    configure()
    initializeSettings()
    setUpSubscribers()
  }
  
  required init(frame frameRect: CGRect) {
    fatalError("init(frame:) has not been implemented")
  }
  
  @MainActor required dynamic init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    let config = ARWorldTrackingConfiguration()
    config.planeDetection = [.horizontal, .vertical]
    
    if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
      config.sceneReconstruction = .mesh
    }
    
    session.run(config)
    
    addCoachingOverlay()
  }
  
  private func addCoachingOverlay() {
    let overlay = ARCoachingOverlayView()
    overlay.goal = .anyPlane
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    overlay.session = self.session
    
    self.addSubview(overlay)
  }
  
  private func initializeSettings() {
    updatePeopleOcclusion(isEnabled: sessionSettings.isPeopleOcclusionEnabled)
    updateObjectOcclusion(isEnabled: sessionSettings.isObjectOcclusionEnabled)
    updateLidarDebug(isEnabled: sessionSettings.isLidarDebugEnabled)
    updateMultiuser(isEnabled: sessionSettings.isMultiuserEnabled)
  }
  
  private func setUpSubscribers() {
//    peopleOcclusionCancellable = sessionSettings.$isPeopleOcclusionEnabled
//      .sink { [weak self] isEnabled in
//        self?.updatePeopleOcclusion(isEnabled: isEnabled)
//      }
    
//    objectOcclusionCancellable = sessionSettings.$isObjectOcclusionEnabled
//      .sink { [weak self] isEnabled in
//        self?.updateObjectOcclusion(isEnabled: isEnabled)
//      }
    
//    lidarDebugCancellable = sessionSettings.$isLidarDebugEnabled
//      .sink { [weak self] isEnabled in
//        self?.updateLidarDebug(isEnabled: isEnabled)
//      }
    
//    multiuserCancellable = sessionSettings.$isMultiuserEnabled
//      .sink { [weak self] isEnabled in
//        self?.updateMultiuser(isEnabled: isEnabled)
//      }
    
    sessionSettings.$isPeopleOcclusionEnabled
      .sink { [weak self] isEnabled in
        self?.updatePeopleOcclusion(isEnabled: isEnabled)
      }
      .store(in: &cancellables)
    
    sessionSettings.$isObjectOcclusionEnabled
      .sink { [weak self] isEnabled in
        self?.updateObjectOcclusion(isEnabled: isEnabled)
      }
      .store(in: &cancellables)
    
    sessionSettings.$isLidarDebugEnabled
      .sink { [weak self] isEnabled in
        self?.updateLidarDebug(isEnabled: isEnabled)
      }
      .store(in: &cancellables)
    
    sessionSettings.$isMultiuserEnabled
      .sink { [weak self] isEnabled in
        self?.updateMultiuser(isEnabled: isEnabled)
      }
      .store(in: &cancellables)
  }
  
  private func updatePeopleOcclusion(isEnabled: Bool) {
    print("\(#file): isPeopleOcclusionEnabled is now \(isEnabled)")
    
    guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth),
          let config = session.configuration as? ARWorldTrackingConfiguration
    else {
      return
    }
    
    if config.frameSemantics.contains(.personSegmentationWithDepth) {
      config.frameSemantics.remove(.personSegmentationWithDepth)
    } else {
      config.frameSemantics.insert(.personSegmentationWithDepth)
    }
    
    session.run(config)
  }
  
  private func updateObjectOcclusion(isEnabled: Bool) {
    print("\(#file): isObjectOcclusionEnabled is now \(isEnabled)")
    
    if environment.sceneUnderstanding.options.contains(.occlusion) {
      environment.sceneUnderstanding.options.remove(.occlusion)
    } else {
      environment.sceneUnderstanding.options.insert(.occlusion)
    }
  }
  
  private func updateLidarDebug(isEnabled: Bool) {
    print("\(#file): isLidarDebugEnabled is now \(isEnabled)")
    
    if debugOptions.contains(.showSceneUnderstanding) {
      debugOptions.remove(.showSceneUnderstanding)
    } else {
      debugOptions.insert(.showSceneUnderstanding)
    }
  }
  
  private func updateMultiuser(isEnabled: Bool) {
    print("\(#file): isMultiuserEnabled is now \(isEnabled)")
  }
}

