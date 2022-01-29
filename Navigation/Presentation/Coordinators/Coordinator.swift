import UIKit

protocol Coordinator: class {
    var navigationController : UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
