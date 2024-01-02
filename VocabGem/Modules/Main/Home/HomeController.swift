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
    
    var viewModel: HomeViewModel
    
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
    
    private lazy var clearRecentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🗑️ Clear recent words", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        button.addTarget(self, action: #selector(didTapClearRecentWords), for: .touchUpInside)
        
        return button
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            try await viewModel.fetchRecentWords()
            configureClearButton()
            tableView.reloadData()
        }
    }
    
    init(viewModel: HomeViewModel) {
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
    
    @objc func didTapClearRecentWords() {
        Task {
            try await viewModel.clearRecentWords()
            tableView.reloadData()
            configureClearButton()
        }
    }
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        view.backgroundColor = .beigeMist
        
        let stack = UIStackView(arrangedSubviews: [appLabel, greetingsLabel])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        view.addSubview(searchBar)
        searchBar.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 86, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(tableView)
        tableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: 8, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(clearRecentsButton)
        clearRecentsButton.centerX(inView: view, topAnchor: tableView.bottomAnchor, paddingTop: 8)
        
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
    
    private func configureClearButton() {
        clearRecentsButton.isHidden = viewModel.clearRecentsButtonVisibility()
    }
}

//MARK: - UISearchBarDelegate

extension HomeController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            Task {
                try await self?.viewModel.searchWords(letterPattern: searchText)
                self?.tableView.reloadData()
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDataSoruce/Delegate

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.determineRecentsOrSearch(atIndex: indexPath.item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task {
            await viewModel.didSelectRowAt(index: indexPath.item)
        }
    }
    
}
