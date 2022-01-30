import UIKit

final class ProfileHeaderView: UIView {
    
    // MARK: - Public Properties
    
    public var onlogOutButtonTap: (() -> Void)?
    public var onAvatarTap: ((UIImage?) -> Void)?
    public var avatarImageSize = CGSize(width: 100, height: 100)
    
    public lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.borderColor = UIColor.createColor(
            lightMode: Colors.white,
            darkMode: Colors.black
        ).cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageSize.height / 2
        avatarImageView.clipsToBounds = true
        let tapAvatarGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(avatarTapped)
        )
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapAvatarGestureRecognizer)
        return avatarImageView
    }()
    
    // MARK: - Private Properties
    
    private var statusText = ""

    private let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return fullNameLabel
    }()

    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = UIColor.createColor(lightMode: Colors.lightGray, darkMode: Colors.gray)
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return statusLabel
    }()
    
    private let statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        statusTextField.layer.cornerRadius = 12
        statusTextField.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.createColor(
            lightMode: Colors.black,
            darkMode: Colors.white
        ).cgColor
        statusTextField.leftView = UIView(
            frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height)
        )
        statusTextField.leftViewMode = .always
        return statusTextField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.backgroundColor = .blue
        setStatusButton.setTitle(ProfileFlowLocalization.setStatusButton.localizedValue, for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setStatusButton.clipsToBounds = true
        setStatusButton.roundCornersWithRadius(14, top: true, bottom: true, shadowEnabled: true)
        return setStatusButton
    }()
    
    private lazy var logOutButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.backgroundColor = .blue
        setStatusButton.setTitle(ProfileFlowLocalization.logOutButton.localizedValue, for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        setStatusButton.clipsToBounds = true
        setStatusButton.roundCornersWithRadius(14, top: true, bottom: true, shadowEnabled: true)
        return setStatusButton
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAvatar()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configure(with viewModel: ProfileTableHeaderViewModel) {
        avatarImageView.image = viewModel.avatarImage
        fullNameLabel.text = viewModel.fullNameLabel
        statusLabel.text = viewModel.statusLabel
        statusTextField.placeholder = viewModel.statusPlaceholder
        statusTextField.text = viewModel.statusText
    }
    
    public func addAvatar() {
        addSubview(avatarImageView)
        
        let constraints = [
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Private Methods
    
    @objc private func avatarTapped() {
        avatarImageView.removeFromSuperview()
        onAvatarTap?(avatarImageView.image)
    }
    
    @objc private func buttonPressed() {
        statusLabel.text = statusTextField.text
    }
    
    @objc private func logOut() {
        onlogOutButtonTap?()
    }
    
    private func addSubviews() {
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        addSubview(logOutButton)
    }
    
    private func setupLayout() {
        let constraints = [
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 132),
            fullNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 25),
            statusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 132),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 132),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 10),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            logOutButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            logOutButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
