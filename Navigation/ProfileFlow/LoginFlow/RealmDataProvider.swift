
import UIKit
import RealmSwift

@objcMembers class CachedCredential: Object {
    dynamic var id: String?
    dynamic var account: String?
    dynamic var password: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class RealmDataProvider: DataProvider {
    
    private var realm: Realm? {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("credentials.realm")
        return try? Realm(configuration: config)
    }
    
    func getCredentials() -> [Credential] {
        return realm?.objects(CachedCredential.self).compactMap {
            guard let id = $0.id, let account = $0.account, let password = $0.password else { return nil}
            return Credential(id: id, account: account, password: password)
        } ?? []
    }
    
    func addCredentials(_ credential: Credential) {
        let cachedCredential = CachedCredential()
        cachedCredential.id = credential.id
        cachedCredential.account = credential.account
        cachedCredential.password = credential.password
        
        try? realm?.write {
            realm?.add(cachedCredential)
        }
    }
    
    func deleteCredentials(_ credential: Credential) {
        guard let cachedCredential = realm?.object(ofType: CachedCredential.self, forPrimaryKey: credential.id) else { return }
        
        try? realm?.write {
            realm?.delete(cachedCredential)
        }
    }
}
    

