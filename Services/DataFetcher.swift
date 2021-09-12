//
//  DataFetcher.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 15.10.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getfeed(response: @escaping (FeedResponse?)-> Void)
    func getUser(response: @escaping (UserResponse?)-> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking
    
    private let authService: AuthService
    
    init(networking: Networking, authService: AuthService = AppDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getfeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
            
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userID else { return }
        let params = ["user_ids": userId, "fields": "photo_100"]
        
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            return response(decoded?.response.first)
        }
        
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
