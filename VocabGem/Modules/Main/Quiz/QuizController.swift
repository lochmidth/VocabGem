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
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        view.backgroundColor = .warmIvory
    }
}
