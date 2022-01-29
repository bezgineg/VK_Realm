import UIKit

class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator: LoginCoordinator?

    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tableHeaderViewModel = ProfileTableHeaderViewModel()
        let profileViewController = ProfileViewController(tableHeaderViewModel: tableHeaderViewModel)
        profileViewController.coordinator = self
        navigationController.show(profileViewController, sender: self)
    }
    
    func pushPhotosVC() {
        let photosCoordinator = PhotosCoordinator(navigationController: navigationController)
        photosCoordinator.navigationController = navigationController
        childCoordinators.append(photosCoordinator)
        photosCoordinator.parentCoordinator = self
        photosCoordinator.start()
    }
    
    func didFinishProfile() {
        parentCoordinator?.childDidiFinish(self)
    }
    
    func childDidiFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func showAlert(with title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        navigationController.present(alertController, animated: false, completion: nil)
    }
    
    func logOut() {
        parentCoordinator?.logOut()
        parentCoordinator?.navigationController.popViewController(animated: true)
    }

}



