//
//  UserService.swift
//  CoverageXUser
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import Foundation
import Combine

class UserService {
    func fetchUsers() -> AnyPublisher<[User], APIError> {
        /**
         By using `guard` we can early exit from the function if the url is not according to URL expected format
         */
        guard let url = URL(string: "https://randomuser.me/api/?results=20") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .mapError(APIError.from)
            .receive(on: DispatchQueue.main)    //  Ensures UI updates happen on the main thread
            .eraseToAnyPublisher()  //  Type-erasure to return a clean AnyPublisher<[User], APIError>
    }
}
