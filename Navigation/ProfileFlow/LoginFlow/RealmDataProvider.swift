
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
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]

        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }

        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })
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
    

