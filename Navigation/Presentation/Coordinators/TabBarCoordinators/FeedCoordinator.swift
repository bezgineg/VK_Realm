import UIKit

final class FeedCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        feedViewController.tabBarItem.title = TabBarLocalization.feed.localizedValue

        if #available(iOS 13.0, *) {
            feedViewController.tabBarItem.image = UIImage(systemName: "house.fill")
            feedViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        }
        navigationController.show(feedViewController, sender: self)
    }
    
    public func pushPostVC() {
        let postCoordinator = PostCoordinator(navigationController: navigationController)
        postCoordinator.navigationController = navigationController
        childCoordinators.append(postCoordinator)
        postCoordinator.parentCoordinator = self
        postCoordinator.start()
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
