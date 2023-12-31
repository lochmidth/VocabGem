//
//  LoginController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit

class AuthController: UIViewController {
    //MARK: - Properties
    
    var viewModel: AuthViewModel?
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 150, width: 150)
        iv.image = UIImage(named: "GitHub_logo")
        return iv
    }()
    
    private lazy var emailContainerText = Utilities().inputContainerView(withImage: UIImage(named: "person"), textField: emailTextField)
    
    private lazy var passwordContainerText = Utilities().inputContainerView(withImage: UIImage(named: "lock"), textField: passwordTextField)
    
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .mutedTaupe
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 50, width: 150)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginWithAppleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Sign in with Apple", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .mutedTaupe
        button.setTitleColor(.black, for: .normal)
        button.setDimensions(height: 50, width: 150)
        button.addTarget(self, action: #selector(handleLoginWithApple), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func handleShowSignUp() {
        print("DEBUG: Handle Go To Register")
    }
    
    @objc func handleLogin() {
        print("DEBUG: Handle Login")
    }
    
    @objc func handleLoginWithApple() {
        print("DEBUG: Handle Login With Apple ID")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .blueStone
        
        view.addSubview(logoImageView)
        logoImageView.center(inView: view, yConstant: -200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerText, passwordContainerText, loginButton, dontHaveAccountButton])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 32, paddingRight: 32)
        
        let divider = UIView()
        divider.backgroundColor = .mutedTaupe
        divider.setHeight(0.75)
        
        view.addSubview(divider)
        divider.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 36, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(loginWithAppleButton)
        loginWithAppleButton.anchor(top: divider.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 36, paddingLeft: 32, paddingRight: 32)
        
    }
}
