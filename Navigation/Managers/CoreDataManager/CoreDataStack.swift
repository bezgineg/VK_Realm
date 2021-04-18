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
    
    
    func save(context: NSManagedObjectContext) {
       if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createObject<T: NSManagedObject> (from entity: T.Type) -> T {
        let context = getContext()
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
        
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
}
