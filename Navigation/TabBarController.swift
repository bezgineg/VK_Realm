
import UIKit

class TabBarController: UITabBarController {
    
    let feedCoordinator = FeedCoordinator()
    let loginCoordinator = LoginCoordinator()
    
    private var feedViewController: UIViewController {
        return self.feedCoordinator.navigationController!
    }
    
    private var loginViewController: UIViewController {
        return self.loginCoordinator.navigationController!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .white
        setupTabBarController()
    }
    
    func setupTabBarController() {

        if #available(iOS 13.0, *) {
            feedViewController.tabBarItem.image = UIImage(systemName: "house.fill")
            feedViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
            feedViewController.tabBarItem.title = "Feed"
        } else {
            
        }
        
        if #available(iOS 13.0, *) {
            loginViewController.tabBarItem.image = UIImage(systemName: "person.fill")
            loginViewController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
            loginViewController.tabBarItem.title = "Profile"
        } else {
            
        }
        
        viewControllers = [feedViewController, loginViewController]
    }

}
