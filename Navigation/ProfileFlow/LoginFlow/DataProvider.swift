
import Foundation

protocol DataProvider: class {

    func getCredentials() -> [Credential]
    func addCredentials(_ credential: Credential)
    func deleteCredentials(_ credential: Credential)
}
