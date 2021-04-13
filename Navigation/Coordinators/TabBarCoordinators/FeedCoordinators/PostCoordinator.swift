import UIKit

class PostCoordinator: Coordinator {

    var childCoordinators =  [Coordinator]()
    weak var parentCoordinator: FeedCoordinator?
    
    weak var navigationController: UINavigationController?
    
    func start() {
        let postViewController = PostViewController()
        postViewController.coordinator = self
        guard let navigator = navigationController else { return }
        navigator.show(postViewController, sender: self)
    }
    
    func present() {
        guard let navigator = navigationController else { return }
        let infoCoordinator = InfoCoordinator()
        infoCoordinator.navigationController = navigator
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

