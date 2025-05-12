//
//  UsersViewController.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 09/05/25.
//

import UIKit

class UsersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var cvUsers: UICollectionView!
    @IBOutlet weak var ncTittle: UINavigationItem!
    
    let base_url: String = "https://randomuser.me/api/?results=50"
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvUsers.dataSource = self
        cvUsers.delegate = self
        print("hola estoy en users VC")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: cvUsers.frame.width, height: 100)
        
        cvUsers.collectionViewLayout = layout

        fetchUsers()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bbtnBack = UIBarButtonItem()
        bbtnBack.title = "Atrás"
        bbtnBack.tintColor = .white
        ncTittle.backBarButtonItem = bbtnBack
        //en la siguiente propiedad ira el boton para poder filtrar por genero o para restablever
        
        
        let maleAction = UIAction(title: "Masculino", image: UIImage(named: "maleIcon")) { _ in
            self.fetchUsers(gender: .male)
        }
        
        let femaleAction = UIAction(title: "Femenino", image: UIImage(named: "femaleIcon")) { _ in
            self.fetchUsers(gender: .female)
        }
        
        let genderMenu = UIMenu(title: "Seleccionar Género", children: [maleAction, femaleAction])
        
        let bbtnRight = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), menu: genderMenu)
        
        ncTittle.rightBarButtonItem = bbtnRight
        
        let bbtnLeft = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reloadUsers))
        
        
        bbtnLeft.tintColor = .systemBlue
        
        ncTittle.leftBarButtonItem = bbtnLeft
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let user = sender as? User,
           let vcUserDetail = segue.destination as? UserDetailViewController {
            print("user sugue prepare", user.email)

            vcUserDetail.user = user
        }
    }

    
    
    func fetchUsers(gender: Gender = .Default) {
        if let url = URL(string: "https://randomuser.me/api/?results=50&gender=\(gender.rawValue)") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 20
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                print("se mando la request")
                                                
                if let error = error {
                    print(error)
                    print("Error en la solicitud: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No se recibieron datos.")
                    return
                }
                                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                        print(decodedResponse.results)

                        DispatchQueue.main.async {
                            self.users = decodedResponse.results
                            self.cvUsers.reloadData()
                        }
//                        let users = decodedResponse.results
//                        print("Usuarios recibidos: \(users.count)")
                    } catch {
                        print(error)
                        print("Error al procesar los datos: \(error.localizedDescription)")
                    }
                }
            }
            
            task.resume()
            
//            if task.progress.isFinished || task.progress.isCancelled || task.state == .canceling || task.state == .suspended {
//                print("Se cancelo la tarea")
//                task.cancel()
//            }

        } else {
            print("La URL no es válida")
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User selected at: ", indexPath.row)
        performSegue(withIdentifier: "ShowUserDetail", sender: users[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as! UserCollectionViewCell
        
        //buscamos el usuario q esta recorriendo la coleccion
        let user = users[indexPath.row]

        //le mandamos el usuario para configurar la celda
        cell.setUpCell(user: user)
        
        return cell
    }
    
    @objc func reloadUsers() {
        print("reload users")
        self.fetchUsers()
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
