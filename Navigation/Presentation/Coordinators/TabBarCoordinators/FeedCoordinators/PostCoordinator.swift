import UIKit

final class PostCoordinator: Coordinator {

    // MARK: - Public Properties
    
    public weak var parentCoordinator: FeedCoordinator?
    
    public var childCoordinators =  [Coordinator]()
    public var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private let author: Author
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, author: Author) {
        self.navigationController = navigationController
        self.author = author
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let postViewController = PostViewController(author: author)
        postViewController.coordinator = self
        navigationController.show(postViewController, sender: self)
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

