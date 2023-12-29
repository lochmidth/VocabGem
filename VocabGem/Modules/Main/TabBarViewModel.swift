//
//  TabBarViewModel.swift
//  VocabGem
//
//  Created by Alphan Ogün on 29.12.2023.
//

import Foundation

class TabBarViewModel {
    //MARK: - Properties
    
    weak var coordinator: TabBarCoordinator?
    let userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func fetchUser(completion: @escaping(User) -> Void) {
        userService.fetchUser(completion: completion)
    }
}
