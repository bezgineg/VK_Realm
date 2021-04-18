import UIKit

class FeedCoordinator: Coordinator {
    
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        feedViewController.tabBarItem.title = "Feed"
        
        if #available(iOS 13.0, *) {
            feedViewController.tabBarItem.image = UIImage(systemName: "house.fill")
            feedViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
            
        } else {
            
        }
        navigationController.show(feedViewController, sender: self)
    }
    
    func pushPostVC() {
        let postCoordinator = PostCoordinator(navigationController: navigationController)
        postCoordinator.navigationController = navigationController
        childCoordinators.append(postCoordinator)
        postCoordinator.parentCoordinator = self
        postCoordinator.start()
    }
    
    func childDidiFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
