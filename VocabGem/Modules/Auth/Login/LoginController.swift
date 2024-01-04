//
//  LoginController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit
import GoogleSignIn

class LoginController: UIViewController {
    //MARK: - Properties
    
    var viewModel: LoginViewModel
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 150, width: 150)
        iv.image = UIImage(named: Constant.vocabGemLogo)
        return iv
    }()
    
    private lazy var emailContainerText = Utilities().inputContainerView(withImage: UIImage(named: "person"), textField: emailTextField)
    
    private lazy var passwordContainerText = Utilities().inputContainerView(withImage: UIImage(named: "lock"), textField: passwordTextField)
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: Constant.emailText)
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: Constant.passwordText)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constant.loginButtonText, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .mutedTaupe
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 50, width: 150)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton(Constant.dontHaveAccountButtonText, Constant.dontHaveButtonBoldText)
        button.addTarget(self, action: #selector(handleShowRegister), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginWithGoogleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.layer.cornerRadius = 5
        button.setDimensions(height: 50, width: 150)
        button.addTarget(self, action: #selector(handleLoginWithGoogle), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupTapGestureforKeyboardDismissal()
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Actions
    
    @objc func handleShowRegister() {
        showLoader(true)
        Task { @MainActor in
            await viewModel.handleShowRegister()
            showLoader(false)
        }
    }
    
    @objc func handleLogin() {
        showLoader(true)
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Task { @MainActor in
            await viewModel.handleLogin(email: email, password: password)
            showLoader(false)
        }
    }
    
    @objc func handleLoginWithGoogle() {
        showLoader(true)
        Task { @MainActor in
            await viewModel.handleLoginWithGoogle()
            showLoader(false)
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .blueStone
        
        view.addSubview(logoImageView)
        logoImageView.center(inView: view, yConstant: -200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerText, passwordContainerText, loginButton])
        stack.axis = .vertical
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 8, paddingLeft: 32, paddingRight: 32)
        
        let divider = UIView()
        divider.backgroundColor = .mutedTaupe
        divider.setHeight(0.75)
        
        view.addSubview(divider)
        divider.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                       paddingTop: 36, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(loginWithGoogleButton)
        loginWithGoogleButton.anchor(top: divider.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                     paddingTop: 36, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                     paddingLeft: 40, paddingRight: 40)
        
    }
}

//MARK: - Constants

extension LoginController {
    struct Constant {
        static let vocabGemLogo = "VocabGem"
        static let emailText = "Email"
        static let passwordText = "Password"
        static let loginButtonText = "Sign In"
        static let dontHaveAccountButtonText = "Don't have an account?"
        static let dontHaveButtonBoldText = "Sign Up"
    }
}
