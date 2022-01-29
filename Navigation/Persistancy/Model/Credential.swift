

import Foundation


struct Credential {
    let id: String
    let account: String
    let password: String
    
    init(id: String = UUID().uuidString, account: String, password: String) {
        self.id = id
        self.account = account
        self.password = password
    }}
