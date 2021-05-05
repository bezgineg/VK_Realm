
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
        
        var config = Realm.Configuration(encryptionKey: getKey())
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("EncryptedCredentials.realm")
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
        
        try? realm?.write() {
            realm?.add(cachedCredential)
        }
    }
    
    func deleteCredentials(_ credential: Credential) {
        guard let cachedCredential = realm?.object(ofType: CachedCredential.self, forPrimaryKey: credential.id) else { return }
        
        try? realm?.write {
            realm?.delete(cachedCredential)
        }
    }
    
    func getKey() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            // swiftlint:disable:next force_cast
            return dataTypeRef as! Data
        }
        // No pre-existing key from this application, so generate a new one
        // Generate a random encryption key
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        return key
    }
}
    

