//
//  UserNetwork.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 02/01/24.
//
import Combine
import Foundation

typealias UserListPublisher = AnyPublisher<[User], Error>

enum UserNetworkError: Error {
    case invalidURL
    case fetchUserError(String)
}

public class UserNetwork {
    private init() {}
    public static let shared = UserNetwork()
    let backgroundQueue = DispatchQueue(label: "PDLNetwork")
    
    func fetchAllUsers() -> UserListPublisher {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .subscribe(on: backgroundQueue)
            .receive(on: DispatchQueue.main)
            .decode(type: [User].self, decoder: JSONDecoder())
            .mapError{ error in
                return UserNetworkError.fetchUserError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
