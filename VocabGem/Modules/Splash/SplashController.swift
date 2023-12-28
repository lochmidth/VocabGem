//
//  SplashController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//

import UIKit
import FirebaseAuth

class SplashController: UIViewController {
    //MARK: - Properties
    
    
    var viewModel: SplashViewModel?
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 150, width: 150)
        iv.image = UIImage(named: "GitHub_logo")
        return iv
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "VocabGem"
        label.textColor = .warmIvory
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoImageView, logoLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.alpha = 0
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Error while signOut, \(error.localizedDescription)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateLogoAndCheckAuth()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .blueStone
        
        view.addSubview(stack)
        stack.center(inView: view, yConstant: -40)
    }
    
    private func animateLogoAndCheckAuth() {
        UIView.animate(withDuration: 3.0) {
            self.stack.alpha = 1
        } completion: { [weak self] _ in
            self?.viewModel?.checkForAuth()
        }
    }
}
