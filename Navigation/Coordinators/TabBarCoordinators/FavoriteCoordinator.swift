import UIKit

class FavoriteCoordinator: Coordinator {
    
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.coordinator = self
        favoriteViewController.tabBarItem.title = "Favorites"
        
        if #available(iOS 13.0, *) {
            favoriteViewController.tabBarItem.image = UIImage(systemName: "star.fill")
            favoriteViewController.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
            
        } else {
            
        }
        navigationController.show(favoriteViewController, sender: self)
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
}
