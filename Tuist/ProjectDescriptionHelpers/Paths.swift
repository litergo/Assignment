//
//  Paths.swift
//  ProjectDescriptionHelpers
//
//  Created by 19336844 on 22.10.2021.
//

import ProjectDescription

/// Путь до Info.plist файлы
public let infoPlistPath: InfoPlist = "Assignment/Info.plist"

/// Файлы ресурсов (.asset каталоги, файлы локализации и пр.)
public let resourcesPaths: ResourceFileElements = [
  "Assignment/Resources/**"
]

// Модели CoreData
public let coreDataModels: [CoreDataModel] = [
  CoreDataModel("Assignment/CoreData/ManagedObjects/SportEvent.xcdatamodeld")
]

