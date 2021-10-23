//
//  CreateEventModuleAssembly.swift
//  Assignment
//
//  Created by 19336844 on 23.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

final class CreateEventModuleAssembly {
  static func build() -> CreateEventView {
    let viewModel = CreateEventViewModel()
    return CreateEventView(viewModel: viewModel)
  }
}
