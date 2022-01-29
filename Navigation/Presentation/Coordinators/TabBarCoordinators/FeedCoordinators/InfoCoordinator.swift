import UIKit

final class InfoCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    public weak var parentCoordinator: PostCoordinator?
    
    public var childCoordinators =  [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let infoViewController = InfoViewController()
        infoViewController.coordinator = self
        navigationController.present(infoViewController, animated: true, completion: nil)
    }
    
    public func didFinishInfo() {
        parentCoordinator?.childDidiFinish(self)
    }
}
