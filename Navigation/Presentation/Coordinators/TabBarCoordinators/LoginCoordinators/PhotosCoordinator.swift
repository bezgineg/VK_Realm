import UIKit

class PhotosCoordinator: Coordinator {
    
    weak var parentCoordinator: ProfileCoordinator?

    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let photosViewController = PhotosViewController()
        photosViewController.coordinator = self
        navigationController.show(photosViewController, sender: self)
    }
    
    func didFinishPhotos() {
        parentCoordinator?.childDidiFinish(self)
    }
    
    func showAlert(with title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        navigationController.present(alertController, animated: false, completion: nil)
    }
    
}
