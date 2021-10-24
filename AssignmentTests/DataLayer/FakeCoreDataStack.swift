//
//  FakeCoreDataStack.swift
//  AssignmentTests
//
//  Created by 19336844 on 24.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import CoreData
@testable import Assignment

final class FakeCoreDataStack: CoreDataStack {
  var saveMainContextInvoked = false
  
  lazy var mainContext: NSManagedObjectContext =  {
    container.viewContext
  }()
  
  private let container: NSPersistentContainer
  
  func saveMainContext() {
    saveMainContextInvoked = true
    try? mainContext.save()
  }
  
  init() {
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType
    let modelURL = Bundle.main.url(forResource: "SportEvent", withExtension: "momd")!
    let model = NSManagedObjectModel(contentsOf: modelURL)!

    container = NSPersistentContainer(
      name: "SportEvent",
      managedObjectModel: model)
    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
  }
  
  
}
