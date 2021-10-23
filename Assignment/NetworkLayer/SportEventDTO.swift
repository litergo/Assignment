//
//  SportEventDTO.swift
//  Assignment
//
//  Created by 19336844 on 23.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct SportEventDTO {

  
  let ref: DatabaseReference?
  let key: String
  let name: String
  let venue: String
  let duration: Int
  
  internal init(name: String,
                venue: String,
                duration: Int,
                key: String = "") {
    self.ref = nil
    self.key = key
    self.name = name
    self.venue = venue
    self.duration = duration
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: AnyObject],
      let name = value["name"] as? String,
      let venue = value["venue"] as? String,
      let duration = value["duration"] as? Int
    else {
      return nil
    }
    
    self.ref = snapshot.ref
    self.key = snapshot.key
    self.name = name
    self.venue = venue
    self.duration = duration
  }
  
  var any: Any {
    [
      "name": name,
      "venue": venue,
      "duration": duration
    ]
  }
}
