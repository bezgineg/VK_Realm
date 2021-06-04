import Foundation
import CoreData
import EncryptedCoreData

final class CoreDataStack {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentStoreContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        do {
            let options: [AnyHashable: Any] = [NSPersistentStoreFileProtectionKey: FileProtectionType.complete, EncryptedStorePassphraseKey : "password"]
            let store = try container.persistentStoreCoordinator.addPersistentStore(ofType: EncryptedStoreType, configurationName: nil, at: container.persistentStoreDescriptions[0].url, options: options)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return container
    }()
    
    lazy var fetchResultController: NSFetchedResultsController<FavoritePost>  = {
        
        let request = FavoritePost.fetchRequest() as NSFetchRequest<FavoritePost>
        let context = getContext()
        let nameSort = NSSortDescriptor(key: #keyPath(FavoritePost.author), ascending: true)
        request.sortDescriptors = [nameSort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
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
    
    func performResultController() {
        do {
            fetchResultController.fetchRequest.predicate = nil
            try fetchResultController.performFetch()
        } catch {
            assertionFailure()
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
        request.fetchBatchSize = 5
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
    func filterData(authorName: String) {
        do {
            fetchResultController.fetchRequest.predicate = NSPredicate(format: "author CONTAINS[c] %@", authorName)
            try fetchResultController.performFetch()
        } catch {
            fatalError()
        }
     }
}
