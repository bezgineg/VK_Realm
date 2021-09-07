//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Bezgin Evgenii on 9/2/21.
//

import Foundation
import LocalAuthentication

protocol AuthorizationServiceProtocol {
    var error: NSError? { get set }
    var laContext: LAContext { get }
    func authorizeIfPossible(_ authorizationFinished: @escaping (Result<Bool, LAError>) -> Void)
}

final class LocalAuthorizationService: AuthorizationServiceProtocol {
    
    let laContext = LAContext()
    var error: NSError?
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Result<Bool, LAError>) -> Void) {
        laContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "To access data"
            ) { success, error in
            if let error = error as? LAError {
                print(error.localizedDescription)
                authorizationFinished(.failure(error))
            }
            authorizationFinished(.success(true))
        }
    }
}
