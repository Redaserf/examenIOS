//
//  UserCollectionViewCell.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 10/05/25.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imvPhoto: UIImageView!
    @IBOutlet weak var imvGender: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    var user: User!
    
    func setUpCell(user: User){
        self.user = user
        lblName.text = "\(user.name.first) \(user.name.last)"
        lblEmail.text = user.email
        
        loadImageFromSring()
        
        imvPhoto.layer.cornerRadius = imvPhoto.frame.width / 2
//        imvPhoto.layer.borderWidth = 2
//        imvPhoto.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemBlue.cgColor
        
        switch user.gender {
        case "male":
            imvGender.image = UIImage(named: "maleIcon")
        default:
            imvGender.image = UIImage(named: "femaleIcon")
        }
        
    }
    
    func loadImageFromSring(){
        if let url = URL(string: user.picture.medium) {
            DispatchQueue.global().async {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imvPhoto.image = image
                        }
                    } else {
                        print("Ocurrio un error al cargar la imagen")
                    }
                }.resume()
            }
        }
    }
    
}
