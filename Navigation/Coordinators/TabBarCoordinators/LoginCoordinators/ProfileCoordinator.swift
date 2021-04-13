import UIKit

class ProfileCoordinator: Coordinator {

    var childCoordinators =  [Coordinator]()
    weak var parentCoordinator: LoginCoordinator?
    
    weak var navigationController: UINavigationController?
    
    func start() {
        let tableHeaderViewModel = ProfileTableHeaderViewModel()
        let profileViewController = ProfileViewController(tableHeaderViewModel: tableHeaderViewModel)
        profileViewController.coordinator = self
        guard let navigator = navigationController else { return }
        navigator.show(profileViewController, sender: self)
    }
    
    func pushPhotosVC() {
        guard let navigator = navigationController else { return }
        let photosCoordinator = PhotosCoordinator()
        photosCoordinator.navigationController = navigator
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
        guard let navigator = navigationController else { return }
        navigator.present(alertController, animated: false, completion: nil)
    }
    
    func logOut() {
        parentCoordinator?.logOut()
        parentCoordinator?.navigationController?.popViewController(animated: true)
    }

}



