//
//  RegisterController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit

class RegisterController: UIViewController {
    //MARK: - Properties
    
    var viewModel: RegisterViewModel?
    
    private lazy var emailContainerText = Utilities().inputContainerView(withImage: UIImage(named: "mail"), textField: emailTextField)
    
    private lazy var passwordContainerText = Utilities().inputContainerView(withImage: UIImage(named: "lock"), textField: passwordTextField)
    
    private lazy var fullnameContainerText = Utilities().inputContainerView(withImage: UIImage(named: "person"), textField: fullnameTextField)
    
    private lazy var usernameContainerText = Utilities().inputContainerView(withImage: UIImage(named: "person"), textField: usernameTextField)
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full Name")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .mutedTaupe
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 50, width: 150)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", "Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func handleRegister() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        
        viewModel?.register(withCredentials: AuthCredentials(email: email, password: password, fullname: fullname, username: username))
    }
    
    @objc func handleShowLogin() {
        viewModel?.dismissViewController()
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
