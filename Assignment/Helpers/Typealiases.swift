//
//  Typealiases.swift
//  Assignment
//
//  Created by 19336844 on 23.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation

typealias Completion = () -> Void
typealias Callback<T> = (Result<T, Error>) -> Void
