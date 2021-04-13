
import UIKit

final class FeedViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    
    private let buttonView: ButtonView = {
        let view = ButtonView()
        view.toAutoLayout()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        navigationItem.title = "Feed"
        
        buttonOnTapSetup()
        setupLayout()
    }
    
    private func buttonOnTapSetup() {
        if let feedCoordinator = coordinator {
            buttonView.onTap = {
                feedCoordinator.pushPostVC()
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(buttonView)
        
        let constratints = [
            buttonView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.widthAnchor.constraint(equalToConstant: 150),
            buttonView.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(constratints)
    }
}



