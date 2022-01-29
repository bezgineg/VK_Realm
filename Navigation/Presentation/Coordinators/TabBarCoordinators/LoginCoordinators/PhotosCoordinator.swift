import UIKit

final class PhotosCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    public weak var parentCoordinator: ProfileCoordinator?

    public var childCoordinators =  [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let photosViewController = PhotosViewController()
        photosViewController.coordinator = self
        navigationController.show(photosViewController, sender: self)
    }
    
    public func didFinishPhotos() {
        parentCoordinator?.childDidiFinish(self)
    }
    
    public func showAlert(with title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        navigationController.present(alertController, animated: false, completion: nil)
    }
    
}
