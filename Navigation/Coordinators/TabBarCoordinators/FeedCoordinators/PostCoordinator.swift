import UIKit

class PostCoordinator: Coordinator {

    weak var parentCoordinator: FeedCoordinator?
    
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postViewController = PostViewController()
        postViewController.coordinator = self
        navigationController.show(postViewController, sender: self)
    }
    
    func present() {
        let infoCoordinator = InfoCoordinator(navigationController: navigationController)
        infoCoordinator.navigationController = navigationController
        childCoordinators.append(infoCoordinator)
        infoCoordinator.parentCoordinator = self
        infoCoordinator.start()
    }
    
    func didFinishPost() {
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
}

