//
//  QuizController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class QuizController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: QuizViewModel
    
    private let scoreLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let questionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private lazy var answer1Button: UIButton = {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config)
        button.tintColor = .black
        button.tag = 0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var answer2Button: UIButton = {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config)
        button.tintColor = .black
        button.tag = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var answer3Button: UIButton = {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config)
        button.tintColor = .black
        button.tag = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateQuiz()
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Actions
    
    @objc func didButtonTapped(_ sender: UIButton) {
        let highlight = viewModel.checkIfAnswerIsCorrectAndHighlight(index: sender.tag)
        UIView.animate(withDuration: 0.5) {
            sender.backgroundColor = highlight
        } completion: { [weak self] _ in
            sender.backgroundColor = .clear
            self?.updateQuiz()
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        view.backgroundColor = .warmIvory
        
        view.addSubview(scoreLabel)
        scoreLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor,
                           paddingTop: 48)
        
        view.addSubview(questionLabel)
        questionLabel.anchor(top: scoreLabel.bottomAnchor, left:  view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 46, paddingLeft: 8, paddingRight: 8)
        
        let stack = UIStackView(arrangedSubviews: [answer1Button, answer2Button, answer3Button])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        view.addSubview(stack)
        stack.anchor(top: questionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 120, paddingLeft: 6, paddingRight: 6)
    }
    
    private func updateQuiz() {
        let index = viewModel.quizManager.index
        scoreLabel.text = viewModel.scoreText
        questionLabel.text = viewModel.quizManager.questions[index].question
        answer1Button.setTitle(viewModel.quizManager.questions[index].choices[0], for: .normal)
        answer2Button.setTitle(viewModel.quizManager.questions[index].choices[1], for: .normal)
        answer3Button.setTitle(viewModel.quizManager.questions[index].choices[2], for: .normal)
    }
}
