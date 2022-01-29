
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public Properties
    
    public var window: UIWindow?
    
    // MARK: - Public Methods
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let tabBarController = TabBarController()
        window?.rootViewController = tabBarController
        
        LocalNotificationCenter.shared.registerForLatestUpdatesIfPossible()
        
        return true
    }
}

