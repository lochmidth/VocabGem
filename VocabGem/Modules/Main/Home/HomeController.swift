//
//  HomeController.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import UIKit

private let reuseIdentifier = "recentCell"

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    var searchTimer: Timer?
    
    var viewModel: homeViewModel
    
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
    
//    private lazy var wordTextField: UITextField = {
//        let tf = UITextField()
//        tf.setHeight(50)
//        tf.layer.cornerRadius = 4
//        tf.borderStyle = .roundedRect
//        tf.placeholder = "Search for a word"
//
//        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//
//        return tf
//    }()
//
//    private lazy var searchButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setDimensions(height: 50, width: 50)
//        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        button.isEnabled = false
//        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
//
//        return button
//    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for words"
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        return searchBar
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
        configureSearchBar()
    }
    
    init(viewModel: homeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEBUG: \(self) deallocated.")
    }
    
    //MARK: - Actions
    
//    @objc func textFieldDidChange() {
//        searchButton.isEnabled = !(wordTextField.text?.isEmpty ?? true)
//    }
    
//    @objc func didTapSearch() {
//        guard let word = wordTextField.text else { return }
//        wordTextField.text = ""
//        viewModel.didTapSearchButton(withWord: word)
//    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        view.backgroundColor = .beigeMist
        
        let stack = UIStackView(arrangedSubviews: [appLabel, greetingsLabel])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        view.addSubview(searchBar)
//        view.addSubview(searchButton)
        searchBar.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 86, paddingLeft: 16, paddingRight: 16)
//        searchButton.anchor(top: stack.bottomAnchor, left: wordTextField.rightAnchor, right: view.rightAnchor,
//                            paddingTop: 86, paddingLeft: 8, paddingRight: 16)
        
        view.addSubview(tableView)
        tableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: 8, paddingLeft: 16, paddingRight: 16)
        
        greetingsLabel.text = viewModel.greetingText
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.returnKeyType = .done
    }
}

//MARK: - UISearchBarDelegate

extension HomeController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.viewModel.searchWords(letterPattern: searchText)
            self?.tableView.reloadData()
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDataSoruce/Delegate

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.words?.results.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.words?.results.data[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let word = viewModel.words?.results.data[indexPath.item] else { return }
        viewModel.getWordDetails(word: word)
    }
    
}
