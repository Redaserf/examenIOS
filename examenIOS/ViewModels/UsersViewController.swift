//
//  UsersViewController.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 09/05/25.
//

import UIKit

class UsersViewController: UIViewController {

    let base_url: String = "https://randomuser.me/api/?results=50"
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hola estoy en users VC")
        getUsers()

        // Do any additional setup after loading the view.
    }
    
    func getUsers() {
        guard let url = URL(string: base_url) else {
            print("URL inválida: \(base_url)")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("IN DATATASK")
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("json: \(json)")
                } catch {
                    print("Error: No se pudo parsear el JSON")
                }
            }
        }.resume()
        
        RunLoop.current.run(until: Date().addingTimeInterval(15))
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
