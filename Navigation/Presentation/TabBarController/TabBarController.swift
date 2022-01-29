
import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Private Properties
    
    private let feed = FeedCoordinator(navigationController: UINavigationController())
    private let login = LoginCoordinator(navigationController: UINavigationController())
    private let favorite = FavoriteCoordinator(navigationController: UINavigationController())
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        setupTabBarController()
    }
    
    // MARK: - Private Methods
    
    private func setupTabBarController() {
        feed.start()
        login.start()
        favorite.start()
        
        viewControllers = [
            feed.navigationController, login.navigationController, favorite.navigationController
        ]
    }
}
