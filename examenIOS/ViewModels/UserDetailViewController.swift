//
//  UserDetailViewController.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 10/05/25.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User!
private let gradientLayer = CAGradientLayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
//        print(user.email)
        // Do any additional setup after loading the view.
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
