//
//  UsersDelegate.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 13/05/25.
//

import Foundation


protocol UsersDelegate: AnyObject {
    func didReceiveUsers(users: [User])
    func didOccurError(error: Error)
}
