//
//  MainViewModel.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

final class MainViewModel: ObservableObject {
  
  @Published var events: [SportEventModel] = []
  @Published var selectedStorage = 0
  @Published var isError: Bool = false
  
  var filteredEvents: [SportEventModel] {
    if selectedStorage == 1 {
      return events.filter { $0.inRemote }
    } else if selectedStorage == 2 {
      return events.filter { !$0.inRemote }
    } else {
      return events
    }
  }
  
  private let repository: SportEventRepository
  
  init(repository: SportEventRepository) {
    self.repository = repository
    self.fetchEvents()
  }
}

extension MainViewModel {
  func fetchEvents() {
    repository.getSportEvents { result in
      switch result {
      case .success(let events):
        self.events = events
      case .failure(let error):
        self.isError = true
        print(error.localizedDescription)
      }
    }
  }
  
  func refresh() {
    isError = false
    fetchEvents()
  }
  
  func add(event: SportEventModel) {
    events.append(event)
    repository.add(sportEvent: event)
  }
}

