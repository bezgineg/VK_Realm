import UIKit

class FeedCoordinator: Coordinator {
    var childCoordinators =  [Coordinator]()
    weak var parentCoordinator: MainCoordinator?
     
    var navigationController: UINavigationController?
    private let feedViewController: FeedViewController
        
    init() {
        feedViewController = FeedViewController()
        navigationController = UINavigationController(rootViewController: feedViewController)
            
        feedViewController.coordinator = self
    }
    
    func start() {
        
    }
    
    func pushPostVC() {
        guard let navigator = navigationController else { return }
        let postCoordinator = PostCoordinator()
        postCoordinator.navigationController = navigator
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
