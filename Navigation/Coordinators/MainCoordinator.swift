import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [Coordinator] { get set }
}

class MainCoordinator {
    
    var childCoordinators = [Coordinator]()
    
    let tabBarNavigator: UITabBarController
    
    init(tabBarNavigator: UITabBarController) {
        self.tabBarNavigator = tabBarNavigator
    }
}
