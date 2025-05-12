//
//  User.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 09/05/25.
//

import Foundation

struct User: Decodable {
    
    var name: Name
    var email: String
    var gender: String
    var picture: Picture
    var location: Location
    var phone: String
        
}

struct Name: Decodable {
    var title: String
    var first: String
    var last: String
}

struct Picture: Decodable {
    var large: String
    var medium: String
    var thumbnail: String
}

struct Location: Decodable {
    var street: Street
    var city: String
    var state: String
    var country: String
    var postcode: String  // Siempre como String

    enum CodingKeys: String, CodingKey {
        case street, city, state, country, postcode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)

        //Si viene como entero se parsea a String obligatoriamente, si no se decodifica como string
        if let intPostcode = try? container.decode(Int.self, forKey: .postcode) {
            postcode = String(intPostcode)
        } else {
            postcode = try container.decode(String.self, forKey: .postcode)
        }
    }
}



struct Street: Decodable {
    var number: Int
    var name: String
}
