//
//  UserListViewModel.swift
//  CoverageXUser
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import SwiftUI
import Combine

class UserListViewModel: ObservableObject {
    @Published var allUsers: [User] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let userService: UserService

    init(userService: UserService = UserService()) {
        self.userService = userService
    }

    var filteredUsers: [User] {
        guard !searchText.isEmpty else { return allUsers }
        return allUsers.filter {
            $0.name.fullName.lowercased().contains(searchText.lowercased())
        }
    }

    func fetchUsers() {
        isLoading = true
        errorMessage = nil

        userService.fetchUsers()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.allUsers = users
            }
            .store(in: &cancellables)
    }
}
