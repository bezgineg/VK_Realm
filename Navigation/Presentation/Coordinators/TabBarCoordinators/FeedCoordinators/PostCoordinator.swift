import UIKit

final class PostCoordinator: Coordinator {

    // MARK: - Public Properties
    
    public weak var parentCoordinator: FeedCoordinator?
    
    public var childCoordinators =  [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let postViewController = PostViewController()
        postViewController.coordinator = self
        navigationController.show(postViewController, sender: self)
    }
    
    public func present() {
        let infoCoordinator = InfoCoordinator(navigationController: navigationController)
        infoCoordinator.navigationController = navigationController
        childCoordinators.append(infoCoordinator)
        infoCoordinator.parentCoordinator = self
        infoCoordinator.start()
    }
    
    public func didFinishPost() {
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
}

