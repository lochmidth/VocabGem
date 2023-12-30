//
//  WordController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class WordController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: WordViewModel
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .black
//        label.text = "Exaggerate".uppercased()
        return label
    }()
    
    private let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
//        label.text = "verb"
        return label
    }()
    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
//        label.text = "do something to an excessive degree"
        return label
    }()
    
    private let exampleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
//        label.text = "Example Sentence:\ntended to romanticize and exaggerate this `gracious Old South' imagery"
        return label
    }()
    
    private let synonymsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
//        label.text = "Synonyms:\noverdo\namplify\nhyperbolise"
        return label
    }()
    
    private lazy var textToSpeechButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "speaker.wave.2.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setDimensions(height: 50, width: 50)
        
        button.addTarget(self, action: #selector(didTapTextToSpeech), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: WordViewModel) {
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
    
    //MARK: - Actions
    
    @objc func didTapTextToSpeech() {
        guard let word = wordLabel.text else { return }
        viewModel.textToSpeech(word: word)
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(wordLabel)
        wordLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                         paddingTop: 32, paddingLeft: 16)
        
        view.addSubview(partOfSpeechLabel)
        partOfSpeechLabel.anchor(top: wordLabel.bottomAnchor, left: view.leftAnchor,
                                 paddingTop: 8, paddingLeft: 16)
        
        view.addSubview(definitionLabel)
        definitionLabel.anchor(top: partOfSpeechLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                               paddingTop: 32, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(exampleLabel)
        exampleLabel.anchor(top: definitionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                            paddingTop: 24, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(synonymsLabel)
        synonymsLabel.anchor(top: exampleLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(textToSpeechButton)
        textToSpeechButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor,
                                  paddingTop: 32, paddingRight: 16)
        
        wordLabel.text = viewModel.wordText
        partOfSpeechLabel.text = viewModel.partOfSpeechText
        definitionLabel.text = viewModel.definitionText
        exampleLabel.text = viewModel.exampleText
        synonymsLabel.text = viewModel.synonymsText
    }
}
