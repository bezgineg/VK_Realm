
import UIKit

class PostViewController: UIViewController {
    
    var coordinator: PostCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        navigationItem.title = FeedFlowLocalization.postTitle.localizedValue

        if #available(iOS 13.0, *) {
            let barButtonimage = UIImage(systemName: "plus")
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: barButtonimage, style: .plain, target: self, action: #selector(presentInfoVC))
        } else {
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.didFinishPost()
    }
    
    @objc private func presentInfoVC() {
        coordinator?.present()
    }

}
