
import UIKit

class TabBarController: UITabBarController {
    
    let feed = FeedCoordinator(navigationController: UINavigationController())
    let login = LoginCoordinator(navigationController: UINavigationController())
    let favorite = FavoriteCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        setupTabBarController()
    }
    
    func setupTabBarController() {

        feed.start()
        login.start()
        favorite.start()
        
        viewControllers = [feed.navigationController, login.navigationController, favorite.navigationController]
    }
}
