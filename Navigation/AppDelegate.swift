
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tabBarController = TabBarController()
        let mainCoordinator = MainCoordinator(tabBarNavigator: tabBarController)
        window?.rootViewController = mainCoordinator.tabBarNavigator
    
        let appConfiguration = AppConfiguration.allCases.randomElement()
        
        switch appConfiguration {
        case .exampleOne(let urlString), .exampleTwo(let urlString), .exampleThree(let urlString):
            guard let url = URL(string: urlString) else { return false }
            NetworkManager.dataTask(with: url) { string in
                /*if let result = string {
                    //print(result)
                }*/
            }
        default:
            break
        }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //29.89 seconds
    }

}

