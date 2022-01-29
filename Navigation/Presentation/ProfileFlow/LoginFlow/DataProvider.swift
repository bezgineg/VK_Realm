
import Foundation

protocol DataProvider: AnyObject {

    func getCredentials() -> [Credential]
    func addCredentials(_ credential: Credential)
    func deleteCredentials(_ credential: Credential)
}
