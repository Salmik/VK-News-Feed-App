//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 28.10.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
