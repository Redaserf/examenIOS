//
//  UsersViewModel.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 13/05/25.
//

import Foundation


class UsersViewModel {
    
    let service = ApiService.shared
    weak var delegate: UsersDelegate?
    var users: [User] = []
    
    
    func fetchUsers(gender: Gender = .Default){
        service.getUsers(gender: gender, completion: { [weak self] result in
            DispatchQueue.main.async {
                
                guard let self = self else {return}
                
                
                switch result {
                    case .success(let users):
//                        self.users = users
                        self.delegate?.didReceiveUsers(users: users)
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.delegate?.didOccurError(error: error)
                    //manejon de errores (mostrar alerta, dibujar un texto de no se pudieron obtener los usuarios o algo asi)
                }
            }
        })
        
        
    }
    
    
    
    
    
    
    
}
