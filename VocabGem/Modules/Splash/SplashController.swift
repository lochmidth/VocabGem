//
//  SplashController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class SplashController: UIViewController {
    //MARK: - Properties
    
    var viewModel: SplashViewModel
    
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
        label.textColor = .white
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
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLogoAndCheckAuth()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .blueStone
        
        view.addSubview(stack)
        stack.center(inView: view, yConstant: -40)
    }
    
    private func animateLogoAndCheckAuth() {
        UIView.animate(withDuration: 3.0) {
            self.stack.alpha = 1
        } completion: { [weak self] _ in
            self?.showLoader(true)
            Task {
                await self?.viewModel.checkForAuth()
                self?.showLoader(false)
            }
        }
    }
}
