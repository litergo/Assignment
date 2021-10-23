//
//  FirebaseDatabaseProvider.swift
//  Assignment
//
//  Created by 19336844 on 23.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol FirebaseDatabaseProvider {
  func add(event: SportEventModel)
  func getEvents(callback: @escaping Callback<[SportEventModel]>)
}

final class FirebaseDatabaseProviderImp {
  private var urlToDatabase = "https://assignment-ad9d8-default-rtdb.europe-west1.firebasedatabase.app/"
  private lazy var reference = Database.database(url: urlToDatabase).reference(withPath: "events")
  private var observers: [DatabaseHandle] = []
  private var items: [SportEventDTO] = []
  
  init() {
    let completed = reference
      .queryOrderedByKey()
      .observe(.value) { snapshot in
        var newItems: [SportEventDTO] = []
        for child in snapshot.children {
          if let snapshot = child as? DataSnapshot,
             let event = SportEventDTO(snapshot: snapshot) {
            newItems.append(event)
          }
        }
        self.items = newItems
      }
    observers.append(completed)
  }
}

extension FirebaseDatabaseProviderImp: FirebaseDatabaseProvider {
  func getEvents(callback: @escaping Callback<[SportEventModel]>)  {
    reference.getData { _, snapshot in
      var newItems: [SportEventDTO] = []
      for child in snapshot.children {
        if let snapshot = child as? DataSnapshot,
           let event = SportEventDTO(snapshot: snapshot) {
          newItems.append(event)
        }
      }
      self.items = newItems
      let result = newItems.map {
        SportEventModel(name: $0.name, venue: $0.venue, duration: $0.duration, inRemote: true)
      }
      callback(.success(result))
    }
  }
  
  func add(event: SportEventModel) {
    if let key = reference.childByAutoId().key {
      let eventDTO = SportEventDTO(name: event.name,
                                   venue: event.venue,
                                   duration: event.duration)
      
      reference.updateChildValues([key: eventDTO.any])
    }
  }
}
