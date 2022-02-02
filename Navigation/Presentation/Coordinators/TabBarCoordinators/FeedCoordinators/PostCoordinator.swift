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
    
    public func openBrowser(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    public func openShareScreen(url: String, description: String) {
        var items = [Any]()
        items = [url, description]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        navigationController.present(activityVC, animated: true, completion: nil)
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

