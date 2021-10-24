//
//  CreateEventViewModel.swift
//  Assignment
//
//  Created by 19336844 on 23.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

final class CreateEventViewModel: ObservableObject {
  
  var finishFlow: ((SportEventModel) -> Void)?
  
  @Published var nameInput: String = ""
  @Published var venueInput: String = ""
  @Published var durationFormatted: String?
  @Published var shouldSaveOnServer: Bool = false
  @Published var durationInput: String = ""
  {
    didSet {
      if let intValue = Int(durationInput) {
        durationFormatted = DateComponentsFormatter.timeIntervalFormatter.string(from: TimeInterval(intValue))
      } else {
        durationFormatted = nil
      }
    }
  }
  
  var isReadyToAdd: Bool {
    !nameInput.isEmpty &&
    !venueInput.isEmpty &&
    !durationInput.isEmpty
  }
  
  var sportEventModel: SportEventModel? {
    if isReadyToAdd, let duration = Int(durationInput) {
         return SportEventModel(name: nameInput,
                                venue: venueInput,
                                duration: duration,
                                inRemote: shouldSaveOnServer)
       }
    return nil
  }
}
