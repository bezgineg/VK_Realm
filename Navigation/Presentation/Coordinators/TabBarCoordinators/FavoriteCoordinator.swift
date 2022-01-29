import UIKit

final class FavoriteCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    public var childCoordinators =  [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.coordinator = self
        favoriteViewController.tabBarItem.title = TabBarLocalization.favorite.localizedValue

        if #available(iOS 13.0, *) {
            favoriteViewController.tabBarItem.image = UIImage(systemName: "star.fill")
            favoriteViewController.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        }
        navigationController.show(favoriteViewController, sender: self)
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
}
