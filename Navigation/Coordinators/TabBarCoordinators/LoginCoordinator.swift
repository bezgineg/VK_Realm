import UIKit

class LoginCoordinator: Coordinator {
    
    var childCoordinators =  [Coordinator]()
    weak var parentCoordinator: MainCoordinator?

    var navigationController: UINavigationController?
    private let loginViewController: LogInViewController
    let dataProvider: DataProvider = RealmDataProvider()
        
    init() {
        
        loginViewController = LogInViewController()
        
        navigationController = UINavigationController(rootViewController: loginViewController)
        loginViewController.coordinator = self
        
        checkCurrentUser()
    }
    
    private func checkCurrentUser() {
        let credential = dataProvider.getCredentials()
        if !credential.isEmpty {
            pushProfileVC()
        }
    }
    
    func pushProfileVC() {
        guard let navigator = navigationController else { return }
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.navigationController = navigator
        childCoordinators.append(profileCoordinator)
        profileCoordinator.parentCoordinator = self
        profileCoordinator.start()
    }
    
    func childDidiFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func logOut() {
        let credential = dataProvider.getCredentials()[0]
        dataProvider.deleteCredentials(credential)
    }
}
