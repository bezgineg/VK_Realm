//
//  LoginView.swift
//  Navigation
//
//  Created by Евгений on 29.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol LoginViewDelegate: AnyObject {
    func loginView(_ loginView: LoginView, createLoginWith login: String?, password: String?)
    func loginView(biometryButtonTappedAt loginView: LoginView)
}

final class LoginView: UIView {
    
    // MARK: - Public Properties
    
    public weak var delegate: LoginViewDelegate?
    
    // MARK: - Private Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.setupTextField()
        textField.placeholder = LoginFlowLocalization.loginPlaceholder.localizedValue
        textField.addTarget(self, action: #selector(checkField), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.setupTextField()
        textField.placeholder = LoginFlowLocalization.passwordPlaceholder.localizedValue
        textField.addTarget(self, action: #selector(checkField), for: .editingChanged)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.createColor(lightMode: Colors.lightGray, darkMode: Colors.gray).cgColor
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.setTitle(LoginFlowLocalization.loginButtonTitle.localizedValue, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.2), for: .disabled)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.createColor(lightMode: Colors.lightGray, darkMode: Colors.gray)
        return divider
    }()
    
    private lazy var biometryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(biometryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func clearTextFields() {
        loginTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
    }
    
    public func setupKeyboardShowing(keyboardSize: CGRect) {
        scrollView.contentInset.bottom = keyboardSize.height
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: keyboardSize.height,
            right: 0
        )
    }
    
    public func setupKeyboardHiding() {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    public func enableBiometryButton(isEnabled: Bool) {
        biometryButton.isEnabled = isEnabled
    }
    
    public func setupBiometryButtonIcon(biometryType: LABiometryType) {
        switch biometryType {
        case .none:
            biometryButton.setImage(UIImage(named: "logo"), for: .normal)
        case .touchID:
            if #available(iOS 13.0, *) {
                biometryButton.setImage(UIImage(systemName: "touchid"), for: .normal)
            } else {
                biometryButton.setImage(UIImage(named: "logo"), for: .normal)
            }
        case .faceID:
            if #available(iOS 13.0, *) {
                biometryButton.setImage(UIImage(systemName: "faceid"), for: .normal)
            } else {
                biometryButton.setImage(UIImage(named: "logo"), for: .normal)
            }
        @unknown default:
            return
        }
    }
    
    // MARK: - Private Methods
    
    @objc private func logInButtonTapped() {
        delegate?.loginView(self, createLoginWith: loginTextField.text, password: passwordTextField.text)
    }
    
    @objc private func biometryButtonTapped() {
        delegate?.loginView(biometryButtonTappedAt: self)
    }
    
    @objc private func checkField() {
        guard let login = loginTextField.text, let password = passwordTextField.text,
              !login.isEmpty, !password.isEmpty else {
            logInButton.isEnabled = false
            return
            }
        logInButton.isEnabled = true
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(logInButton)
        contentView.addSubview(biometryButton)
    }
    
    private func setupLayout() {
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: 120
            ),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            
            dividerView.heightAnchor.constraint(equalToConstant: 0.5),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            logInButton.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -12
            ),
            
            biometryButton.widthAnchor.constraint(equalToConstant: 50),
            biometryButton.heightAnchor.constraint(equalToConstant: 50),
            biometryButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            biometryButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
