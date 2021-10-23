//
//  CoreDataStack.swift
//  Assignment
//
//  Created by 19336844 on 22.10.2021.
//  Copyright © 2021 avmishchenko. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStack {
  var mainContext: NSManagedObjectContext { get }
  func saveMainContext()
}

final class CoreDataStackImp {
  
  var storeContainer: NSPersistentContainer
  
  init(with modelName: String) {
    let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
    let model = NSManagedObjectModel(contentsOf: modelURL)!
    storeContainer = NSPersistentContainer(name: modelName, managedObjectModel: model)
    storeContainer.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
}

extension CoreDataStackImp: CoreDataStack {
  var mainContext: NSManagedObjectContext {
    storeContainer.viewContext
  }
  
  func saveMainContext() {
    mainContext.perform {
      do {
        try self.mainContext.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
}
