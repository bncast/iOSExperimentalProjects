//
//  CoreDataHandler.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import CoreData
import UIKit

class CoreDataHandler {
    
    private let viewContext:NSManagedObjectContext
//    private let backgroundContext:NSManagedObjectContext
    
    static let shared = CoreDataHandler()
    init() {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        self.viewContext = container.viewContext
        
//        self.backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        self.backgroundContext.parent = viewContext
    }
    
//    func performBackground(block: @escaping () -> Void){
//        let queue = DispatchQueue(label: "CoreDataQueue")
//
//        queue.async {
//            self.backgroundContext.perform {
//                block()
//            }
//        }
//    }
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.viewContext) else { return nil }
        
        let object = T(entity: entity, insertInto: self.viewContext)
        return object
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func checkIfItemExist<T: NSManagedObject>(id: Int, _ type: T.Type) -> Bool {
        guard let entityName = T.entity().name else { return false }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)

        do {
            let count = try self.viewContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }

    
    func save(){
        do {
            try self.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete<T:NSManagedObject>(object: T) {
        self.viewContext.delete(object)
        save()
    }
}

