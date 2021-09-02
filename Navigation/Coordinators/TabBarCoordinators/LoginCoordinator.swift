import UIKit

class LoginCoordinator: Coordinator {
    
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    let dataProvider: DataProvider = RealmDataProvider()
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        
        if #available(iOS 13.0, *) {
            loginViewController.tabBarItem.image = UIImage(systemName: "person.fill")
            loginViewController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
            
        } else {
            // Fallback on earlier versions
        }
        
        loginViewController.tabBarItem.title = TabBarLocalization.profile.localizedValue
        navigationController.show(loginViewController, sender: self)
        
        checkCurrentUser()
    }
    
    private func checkCurrentUser() {
        let credential = dataProvider.getCredentials()
        if !credential.isEmpty {
            pushProfileVC()
        }
    }
    
    func pushProfileVC() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.navigationController = navigationController
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
        guard !dataProvider.getCredentials().isEmpty else { return }
        let credential = dataProvider.getCredentials()[0]
        dataProvider.deleteCredentials(credential)
    }
}
