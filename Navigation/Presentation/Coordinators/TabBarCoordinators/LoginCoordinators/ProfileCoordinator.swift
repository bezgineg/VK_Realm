import UIKit

final class ProfileCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    public weak var parentCoordinator: LoginCoordinator?

    public var childCoordinators =  [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let tableHeaderViewModel = ProfileTableHeaderViewModel()
        let photosViewModel = PhotosTableViewCellViewModel()
        let profileViewController = ProfileViewController(
            tableHeaderViewModel: tableHeaderViewModel,
            photosViewModel: photosViewModel
        )
        profileViewController.coordinator = self
        navigationController.show(profileViewController, sender: self)
    }
    
    public func pushPhotosVC() {
        let photosCoordinator = PhotosCoordinator(navigationController: navigationController)
        photosCoordinator.navigationController = navigationController
        childCoordinators.append(photosCoordinator)
        photosCoordinator.parentCoordinator = self
        photosCoordinator.start()
    }
    
    public func didFinishProfile() {
        parentCoordinator?.childDidiFinish(self)
    }
    
    public func childDidiFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    public func showAlert(with title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        navigationController.present(alertController, animated: false, completion: nil)
    }
    
    public func logOut() {
        parentCoordinator?.logOut()
        parentCoordinator?.navigationController.popViewController(animated: true)
    }
}
