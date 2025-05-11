//
//  UsersApiResponse.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 10/05/25.
//

import Foundation

struct ApiResponse: Decodable {
    var results: [User]
}

struct Info: Decodable {
    var results: Int
    var pages: Int
}
