//
//  RegisterController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit

class RegisterController: UIViewController {
    //MARK: - Properties
    
    var viewModel: RegisterViewModel
    
    private lazy var emailContainerText = Utilities().inputContainerView(withImage: UIImage(named: Constant.emailContainerImage),
                                                                         textField: emailTextField)
    
    private lazy var passwordContainerText = Utilities().inputContainerView(withImage: UIImage(named: Constant.passwordContainerImage),
                                                                            textField: passwordTextField)
    
    private lazy var fullnameContainerText = Utilities().inputContainerView(withImage: UIImage(named: Constant.nameContainerImage),
                                                                            textField: fullnameTextField)
    
    private lazy var usernameContainerText = Utilities().inputContainerView(withImage: UIImage(named: Constant.nameContainerImage),
                                                                            textField: usernameTextField)
    
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
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: Constant.fullnameText)
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: Constant.usernameText)
        return tf
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constant.registerButtonText, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .mutedTaupe
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 50, width: 150)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton(Constant.alreadyHaveAccountButtonText,
                                                  Constant.alreadyHaveAccountButtonBoldText)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: RegisterViewModel) {
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
    
    @objc func handleRegister() {
        showLoader(true)
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        Task { @MainActor in
            await viewModel.register(withCredentials: AuthCredentials(email: email, password: password, fullname: fullname, username: username))
            showLoader(false)
        }
    }
    
    @objc func handleShowLogin() {
        showLoader(true)
        Task { @MainActor in
            await viewModel.dismissViewController()
            showLoader(false)
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        view.backgroundColor = .blueStone
        
        let stack = UIStackView(arrangedSubviews: [emailContainerText, passwordContainerText, fullnameContainerText, usernameContainerText, registerButton])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 16, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                        paddingLeft: 40, paddingRight: 40)
    }
}

//MARK: - Constants

extension RegisterController {
    struct Constant {
        static let emailContainerImage = "mail"
        static let passwordContainerImage = "lock"
        static let nameContainerImage = "person"
        static let emailText = "Email"
        static let passwordText = "Password"
        static let fullnameText = "Full name"
        static let usernameText = "Username"
        static let registerButtonText = "Register"
        static let alreadyHaveAccountButtonText = "Already have an account?"
        static let alreadyHaveAccountButtonBoldText = "Log in"
    }
}
