//
//  SportEventModel.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

struct SportEventModel: Identifiable {
  var id = UUID()
  let name: String
  let venue: String
  let duration: Int
  let inRemote: Bool
}

