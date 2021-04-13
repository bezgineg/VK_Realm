
import UIKit

class LoginPassChecker {
    
    static let shared = LoginPassChecker()
    
    let loginData = ""
    let passwordData = ""
    
    private init() {}
    
    func loginCheck(_ login: String) throws -> Bool {
        if loginData == login {
            return true
        } else  {
            throw LoginErrors.invalidLogin
        }
    }
    
    func passwordCheck(_ password: String) throws -> Bool {
        if passwordData == password {
            return true
        } else {
            throw LoginErrors.invalidPassword
        }
    }
}
