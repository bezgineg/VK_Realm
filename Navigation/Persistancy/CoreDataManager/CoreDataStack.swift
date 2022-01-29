import Foundation
import CoreData
import EncryptedCoreData

protocol DataStorageProtocol {
    var fetchResultController: NSFetchedResultsController<FavoritePost> { get set }
    
    func getContext()  -> NSManagedObjectContext
    func getBackgroundContext()  -> NSManagedObjectContext
    func save(context: NSManagedObjectContext)
    func performResultController()
    func createObject<T: NSManagedObject> (from entity: T.Type, context: NSManagedObjectContext) -> T
    func delete(object: NSManagedObject)
    func fetchData<T: NSManagedObject>(for entity: T.Type) -> [T]
    func filterData(authorName: String)
}

final class CoreDataStack: DataStorageProtocol {
    
    // MARK: - Public Properties
    
    public lazy var fetchResultController: NSFetchedResultsController<FavoritePost>  = {
        
        let request = FavoritePost.fetchRequest() as NSFetchRequest<FavoritePost>
        let context = getContext()
        let nameSort = NSSortDescriptor(key: #keyPath(FavoritePost.author), ascending: true)
        request.sortDescriptors = [nameSort]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        return fetchedResultsController
    }()
    
    // MARK: - Private Properties
    
    private lazy var persistentStoreContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        do {
            let options: [AnyHashable: Any] = [
                NSPersistentStoreFileProtectionKey: FileProtectionType.complete,
                EncryptedStorePassphraseKey : "password"
            ]
            let store = try container.persistentStoreCoordinator.addPersistentStore(
                ofType: EncryptedStoreType,
                configurationName: nil,
                at: container.persistentStoreDescriptions[0].url,
                options: options
            )
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return container
    }()
    
    // MARK: - Private Properties
    
    private let modelName: String
    
    // MARK: - Initializers
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Public Methods
    
    public func getContext()  -> NSManagedObjectContext {
        persistentStoreContainer.viewContext
    }
    
    public func getBackgroundContext()  -> NSManagedObjectContext {
        persistentStoreContainer.newBackgroundContext()
    }
    
    
    public func save(context: NSManagedObjectContext) {
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
    
    public func performResultController() {
        do {
            fetchResultController.fetchRequest.predicate = nil
            try fetchResultController.performFetch()
        } catch {
            assertionFailure()
        }
    }
    
    public func createObject<T: NSManagedObject> (from entity: T.Type, context: NSManagedObjectContext) -> T {
        guard let object = NSEntityDescription.insertNewObject(
            forEntityName: String(describing: entity),
            into: context
        ) as? T else { return T() }
        return object
    }
    
    public func delete(object: NSManagedObject) {
        let context = getContext()
        context.delete(object)
        save(context: context)
    }
    
    public func fetchData<T: NSManagedObject>(for entity: T.Type) -> [T] {
        guard let request = entity.fetchRequest() as? NSFetchRequest<T> else { return [T]() }
        let context = getContext()
        request.fetchLimit = 10
        request.fetchBatchSize = 5
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
    public func filterData(authorName: String) {
        do {
            fetchResultController.fetchRequest.predicate = NSPredicate(
                format: "author CONTAINS[c] %@",
                authorName
            )
            try fetchResultController.performFetch()
        } catch {
            fatalError()
        }
     }
}
