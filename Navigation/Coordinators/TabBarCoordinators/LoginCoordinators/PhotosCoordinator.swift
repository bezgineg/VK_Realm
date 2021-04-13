import UIKit

class PhotosCoordinator: Coordinator {

    var childCoordinators =  [Coordinator]()
    weak var parentCoordinator: ProfileCoordinator?
    
    weak var navigationController: UINavigationController?
    
    func start() {
        let photosViewController = PhotosViewController()
        photosViewController.coordinator = self
        guard let navigator = navigationController else { return }
        navigator.show(photosViewController, sender: self)
    }
    
    func didFinishPhotos() {
        parentCoordinator?.childDidiFinish(self)
    }
    
    func showAlert(with title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        guard let navigator = navigationController else { return }
        navigator.present(alertController, animated: false, completion: nil)
    }
    
}
