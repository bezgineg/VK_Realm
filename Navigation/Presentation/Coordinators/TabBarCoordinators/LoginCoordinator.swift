import UIKit

final class LoginCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    public var childCoordinators =  [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private let dataProvider: DataProvider
        
    // MARK: - Initializers
    
    init(
        navigationController: UINavigationController,
        dataProvider: DataProvider = RealmDataProvider()
    ) {
        self.navigationController = navigationController
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        
        if #available(iOS 13.0, *) {
            loginViewController.tabBarItem.image = UIImage(systemName: "person.fill")
            loginViewController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        }
        
        loginViewController.tabBarItem.title = TabBarLocalization.profile.localizedValue
        navigationController.show(loginViewController, sender: self)
        
        checkCurrentUser()
    }
    
    public func pushProfileVC() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.navigationController = navigationController
        childCoordinators.append(profileCoordinator)
        profileCoordinator.parentCoordinator = self
        profileCoordinator.start()
    }
    
    public func childDidiFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    public func logOut() {
        guard !dataProvider.getCredentials().isEmpty else { return }
        let credential = dataProvider.getCredentials()[0]
        dataProvider.deleteCredentials(credential)
    }
    
    public func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "Something went wrong",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        navigationController.present(alertController, animated: false, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func checkCurrentUser() {
        let credential = dataProvider.getCredentials()
        if !credential.isEmpty {
            pushProfileVC()
        }
    }
}
