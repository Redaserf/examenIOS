//
//  UserCollectionViewCell.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 10/05/25.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    var user: User!
    
    func setUpCell(user: User){
        self.user = user
        lblName.text = "\(user.name.first) \(user.name.last)"
        lblEmail.text = user.email
        lblGender.text = user.gender
        
    }
    
}
