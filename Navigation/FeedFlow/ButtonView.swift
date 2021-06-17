
import UIKit

class ButtonView: UIView {
    
    var onTap: (() -> Void)?

    private let firstPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle(FeedFlowLocalization.firstPostButton.localizedValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(openPost), for: .touchUpInside)
        return button
    }()
    
    private let secondPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle(FeedFlowLocalization.secondPostButton.localizedValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(openPost), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(firstPostButton)
        addSubview(secondPostButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func openPost() {
        onTap?()
    }
    
    private func setupLayout() {
        let constraints = [
            firstPostButton.widthAnchor.constraint(equalToConstant: 200),
            firstPostButton.heightAnchor.constraint(equalToConstant: 30),
            
            secondPostButton.topAnchor.constraint(equalTo: firstPostButton.bottomAnchor),
            secondPostButton.centerXAnchor.constraint(equalTo: firstPostButton.centerXAnchor),
            secondPostButton.widthAnchor.constraint(equalToConstant: 200),
            secondPostButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
