//
//  User.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 09/05/25.
//

import Foundation

struct User: Codable {
    
    var Name: String
    var Email: String
    var Gender: String
    var Image: String
    var Adresse: String
    var Phone: String
    
}

struct UsersResponse: Decodable {
    
    var results: [User]
    
}
