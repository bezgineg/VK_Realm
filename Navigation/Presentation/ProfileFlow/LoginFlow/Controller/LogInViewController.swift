
import UIKit

final class LogInViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var coordinator: LoginCoordinator?
   
    // MARK: - Private Properties
    
    private var authManager: AuthorizationServiceProtocol
    private let mainView = LoginView()
    
    // MARK: - Initializers
    
    init(authManager: AuthorizationServiceProtocol = LocalAuthorizationService()) {
        self.authManager = authManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        enableBiometryButton()
        setupBiometryButtonIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        mainView.clearTextFields()
        removeObservers()
    }
    
    // MARK: - Private Methods
    
    private func setDelegates() {
        mainView.delegate = self
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue {
            mainView.setupKeyboardShowing(keyboardSize: keyboardSize)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        mainView.setupKeyboardHiding()
    }
    
    private func setupBiometryButtonIcon() {
        mainView.setupBiometryButtonIcon(biometryType: authManager.laContext.biometryType)
    }
    
    private func enableBiometryButton() {
        let isEnabled = authManager.laContext.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &authManager.error
        )
        mainView.enableBiometryButton(isEnabled: isEnabled)
    }
}

// MARK: - LoginViewDelegate

extension LogInViewController: LoginViewDelegate {
    func loginView(biometryButtonTappedAt loginView: LoginView) {
        authManager.authorizeIfPossible { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(true):
                DispatchQueue.main.async {
                    self.coordinator?.pushProfileVC()
                }
            case.success(false):
                DispatchQueue.main.async {
                    self.coordinator?.showAlert(message: "Try again")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.coordinator?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    func loginView(_ loginView: LoginView, createLoginWith login: String?, password: String?) {
        guard let login = login, let password = password else { return }
        let credential = Credential(account: login, password: password)
        coordinator?.dataProvider.addCredentials(credential)
        coordinator?.pushProfileVC()
    }
}
