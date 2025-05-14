//
//  UserDetailViewController.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 10/05/25.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var imvHouseIcon: UIImageView!
    @IBOutlet weak var imvPhoneIcon: UIImageView!
    @IBOutlet weak var imvGenderRepresentataion: UIImageView!
    @IBOutlet weak var vwUserDetails: UIView!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var imvGender: UIImageView!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblDetailsAddress: UILabel!
    @IBOutlet weak var lblMainAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imvPhoto: UIImageView!
    
    var user: User!
    private let gradientLayer = CAGradientLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vwUserDetails.alpha = 0
        imvHouseIcon.alpha = 0
        imvPhoto.alpha = 0
        imvGenderRepresentataion.alpha = 0
        lblGender.alpha = 0
        imvGender.alpha = 0
        lblPhone.alpha = 0
        lblDetailsAddress.alpha = 0
        lblMainAddress.alpha = 0
        lblEmail.alpha = 0
        lblName.alpha = 0
        imvPhoto.alpha = 0
        
        vwUserDetails.layer.cornerRadius = 35
        imvPhoto.layer.cornerRadius = imvPhoto.frame.width / 2
        
        imvPhoto.layer.borderWidth = 2
        imvPhoto.layer.borderColor = UIColor.white.cgColor
        
        loadImageFromSring()
        
        lblName.text = user.name.first + " " + user.name.last
        lblEmail.text = user.email
        lblMainAddress.text = user.location.street.name + " " + String(user.location.street.number)
        lblDetailsAddress.text = "Codigo postal \(user.location.postcode) \n- \(user.location.country) \n- \(user.location.state) \n- \(user.location.city)"
        lblPhone.text = user.phone
        lblGender.text = user.gender

        switch user.gender {
            case "male":
            print("male")
                imvGenderRepresentataion.image = UIImage(named: "maleIcon")
            case "female":
            print("female")
                imvGenderRepresentataion.image = UIImage(named: "femaleIcon")
            default:
                break
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            self.vwUserDetails.alpha = 1
            self.imvHouseIcon.alpha = 1
            self.imvPhoto.alpha = 1
            self.imvGenderRepresentataion.alpha = 1
            self.lblGender.alpha = 1
            self.imvGender.alpha = 1
            self.lblPhone.alpha = 1
            self.lblDetailsAddress.alpha = 1
            self.lblMainAddress.alpha = 1
            self.lblEmail.alpha = 1
            self.lblName.alpha = 1
            self.imvPhoto.alpha = 1
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
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
