//
//  WordController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class WordController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: WordViewModel?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        
        navigationController?.navigationBar.isHidden = false
    }
}
