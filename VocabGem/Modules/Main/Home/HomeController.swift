//
//  HomeController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: homeViewModel? {
        didSet { configureViewModel() }
    }
    
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "VocabGem"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        return label
    }()
    
    private let greetingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var wordTextField: UITextField = {
        let tf = UITextField()
        tf.setHeight(50)
        tf.layer.cornerRadius = 4
        tf.borderStyle = .roundedRect
        tf.placeholder = "Search for a word"
        
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        return tf
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(height: 50, width: 50)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        
        return button
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.layer.cornerRadius = 4
        tv.setHeight(300)
        tv.backgroundColor = .white
        return tv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    //MARK: - Actions
    
    @objc func textFieldDidChange() {
        searchButton.isEnabled = !(wordTextField.text?.isEmpty ?? true)
    }
    
    @objc func didTapSearch() {
        guard let word = wordTextField.text else { return }
        wordTextField.text = ""
        viewModel?.didTapSearchButton(withWord: word)
    }
    
    //MARK: - Helpers
    
    private func configureViewModel() {
        greetingsLabel.text = viewModel?.greetingText
    }
    
    private func configureUI() {
        
        view.backgroundColor = .beigeMist
        
        let stack = UIStackView(arrangedSubviews: [appLabel, greetingsLabel])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.center(inView: view, yConstant: -300)
        
        view.addSubview(wordTextField)
        view.addSubview(searchButton)
        wordTextField.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: searchButton.leftAnchor,
                             paddingTop: 86, paddingLeft: 16, paddingRight: 8)
        searchButton.anchor(top: stack.bottomAnchor, left: wordTextField.rightAnchor, right: view.rightAnchor,
                            paddingTop: 86, paddingLeft: 8, paddingRight: 16)
        
        view.addSubview(tableView)
        tableView.anchor(top: wordTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: 16, paddingLeft: 16, paddingRight: 16)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "recentCell")
    }
}

//MARK: - UITableViewDataSoruce/Delegate

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Words"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath)
        cell.textLabel?.text = "Flower"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: Did select \(indexPath.row). word")
    }
    
}
