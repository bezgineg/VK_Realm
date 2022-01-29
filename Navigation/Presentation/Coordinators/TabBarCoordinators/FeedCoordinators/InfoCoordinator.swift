import UIKit

class InfoCoordinator: Coordinator {
    
    weak var parentCoordinator: PostCoordinator?
    
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let infoViewController = InfoViewController()
        infoViewController.coordinator = self
        
        navigationController.present(infoViewController, animated: true, completion: nil)
    }
    
    func didFinishInfo() {
        parentCoordinator?.childDidiFinish(self)
    }
}
