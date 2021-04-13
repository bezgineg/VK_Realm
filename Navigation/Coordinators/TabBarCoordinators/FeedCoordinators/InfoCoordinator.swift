import UIKit

class InfoCoordinator: Coordinator {
    
    var childCoordinators =  [Coordinator]()
    weak var parentCoordinator: PostCoordinator?

    weak var navigationController: UINavigationController?
    
    func start() {
        let infoViewController = InfoViewController()
        infoViewController.coordinator = self
        guard let navigator = navigationController else { return }
        navigator.present(infoViewController, animated: true, completion: nil)
    }
    
    func didFinishInfo() {
        parentCoordinator?.childDidiFinish(self)
    }
}
