import Foundation
import CoreData

final class CoreDataStack {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentStoreContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError()
            }
        }
        return container
    }()
    
    func getContext()  -> NSManagedObjectContext {
        persistentStoreContainer.viewContext
    }
    
    func getBackgroundContext()  -> NSManagedObjectContext {
        persistentStoreContainer.newBackgroundContext()
    }
    
    
    func save(context: NSManagedObjectContext) {
        context.performAndWait {
            if context.hasChanges {
                 do {
                     try context.save()
                 } catch {
                     print(error.localizedDescription)
                 }
             }
        }
    }
    
    func createObject<T: NSManagedObject> (from entity: T.Type, context: NSManagedObjectContext) -> T {
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: entity), into: context) as! T
        return object
    }
    
    func delete(object: NSManagedObject) {
        let context = getContext()
        context.delete(object)
        save(context: context)
    }
    
    func fetchData<T: NSManagedObject>(for entity: T.Type) -> [T] {
        let context = getContext()
        let request = entity.fetchRequest() as! NSFetchRequest<T>
        request.fetchLimit = 10
        request.fetchBatchSize = 1
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
    func filterData<T: NSManagedObject>(for entity: T.Type, authorName: String) -> [T] {
        let context = getContext()
        
        do {
            let request = entity.fetchRequest() as! NSFetchRequest<T>
            request.predicate = NSPredicate(format: "author CONTAINS[c] %@", authorName)
            request.fetchLimit = 5
            request.fetchBatchSize = 1
            return try context.fetch(request)
        } catch {
            fatalError()
        }
     }
}
