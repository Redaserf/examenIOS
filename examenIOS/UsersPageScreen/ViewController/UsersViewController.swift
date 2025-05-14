//
//  UsersViewController.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 09/05/25.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet weak var cvUsers: UICollectionView!
    @IBOutlet weak var ncTittle: UINavigationItem!
    
    let service = ApiService.shared
    let vmUsers = UsersViewModel()
    var users: [User] = []
    let storyboardDestiny = UIStoryboard(name: "UserDetail", bundle: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //que las funciones delegate q pasen en el viewModel se ejecuten aqui
        vmUsers.delegate = self
                
        cvUsers.dataSource = self
        cvUsers.delegate = self
        print("hola estoy en users VC")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: cvUsers.frame.width, height: 100)
        
        cvUsers.collectionViewLayout = layout

        //cargar usuarios
        vmUsers.fetchUsers()


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let bbtnBack = UIBarButtonItem()
        bbtnBack.title = "Atrás"
        bbtnBack.tintColor = .black
        ncTittle.backBarButtonItem = bbtnBack
        //en la siguiente propiedad ira el boton para poder filtrar por genero o para restablever
        
        
        let maleAction = UIAction(title: "Masculino", image: UIImage(named: "maleIcon")) { _ in
            self.vmUsers.fetchUsers(gender: .male)
        }
        
        let femaleAction = UIAction(title: "Femenino", image: UIImage(named: "femaleIcon")) { _ in
            self.vmUsers.fetchUsers(gender: .female)
        }
        
        let genderMenu = UIMenu(title: "Seleccionar Género", children: [maleAction, femaleAction])
        
        let bbtnRight = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), menu: genderMenu)
        
        ncTittle.rightBarButtonItem = bbtnRight
        
        let bbtnLeft = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reloadUsers))
        
        
        bbtnLeft.tintColor = .systemBlue
        
        ncTittle.leftBarButtonItem = bbtnLeft
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if let user = sender as? User,
//           let vcUserDetail = segue.destination as? UserDetailViewController {
//            print("user sugue prepare", user.email)
//
//            vcUserDetail.user = user
//        }
//    }
    
    @objc func reloadUsers() {
        print("reload users")
        self.vmUsers.fetchUsers()
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
