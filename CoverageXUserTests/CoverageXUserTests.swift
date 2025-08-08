//
//  CoverageXUserTests.swift
//  CoverageXUserTests
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import XCTest
import Combine
@testable import CoverageXUser

class MockUserService: UserService {
    var shouldReturnError = false

    override func fetchUsers() -> AnyPublisher<[User], APIError> {
        if shouldReturnError {
            return Fail(error: .networkError(NSError(domain: "Test", code: -1))).eraseToAnyPublisher()
        } else {
            let user = User(id: .init(name: "SSN", value: "1234"), name: .init(title: "Mr", first: "John", last: "Doe"), email: "john@example.com", phone: "1234567890", picture: .init(thumbnail: "", large: ""))
            return Just([user]).setFailureType(to: APIError.self).eraseToAnyPublisher()
        }
    }
}

final class CoverageXUserTests: XCTestCase {

    var viewModel: UserListViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables = nil
    }

    func testFetchUsersSuccess() {
        let service = MockUserService()
        viewModel = UserListViewModel(userService: service)

        let expectation = XCTestExpectation(description: "Fetch users")

        viewModel.$allUsers.dropFirst().sink { users in
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users.first?.name.first, "John")
            expectation.fulfill()
        }.store(in: &cancellables)

        viewModel.fetchUsers()

        wait(for: [expectation], timeout: 1)
    }

    func testFetchUsersFailure() {
        let service = MockUserService()
        service.shouldReturnError = true
        viewModel = UserListViewModel(userService: service)

        let expectation = XCTestExpectation(description: "Fetch error")

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                if error != nil {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchUsers()

        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchFiltering() {
        let mockUser1 = User(
            id: .init(name: "ID", value: "1"),
            name: .init(title: "Mr", first: "John", last: "Smith"),
            email: "john@example.com",
            phone: "123456789",
            picture: .init(thumbnail: "", large: "")
        )

        let mockUser2 = User(
            id: .init(name: "ID", value: "2"),
            name: .init(title: "Ms", first: "Alice", last: "Brown"),
            email: "alice@example.com",
            phone: "987654321",
            picture: .init(thumbnail: "", large: "")
        )

        viewModel = UserListViewModel(userService: MockUserService())
        viewModel.allUsers = [mockUser1, mockUser2]

        viewModel.searchText = "john"
        XCTAssertEqual(viewModel.filteredUsers.count, 1)
        XCTAssertEqual(viewModel.filteredUsers.first?.name.first, "John")

        viewModel.searchText = "alice"
        XCTAssertEqual(viewModel.filteredUsers.count, 1)
        XCTAssertEqual(viewModel.filteredUsers.first?.name.first, "Alice")

        viewModel.searchText = "xyz"
        XCTAssertEqual(viewModel.filteredUsers.count, 0)

        viewModel.searchText = ""
        XCTAssertEqual(viewModel.filteredUsers.count, 2)
    }

}
