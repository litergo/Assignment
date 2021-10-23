//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 19336844 on 22.10.2021.
//

import ProjectDescription

public var packages: [Package] = [
  .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "8.0.0")
]

public var targetDependencies: [TargetDependency] = [
  // Firebase Swift Packages
  .package(product: "FirebaseAnalytics"),
  .package(product: "FirebaseCrashlytics"),
  .package(product: "FirebaseDatabase")
]
