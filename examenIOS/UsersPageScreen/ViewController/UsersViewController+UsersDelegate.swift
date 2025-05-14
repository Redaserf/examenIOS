//
//  UsersViewController+UsersDelegate.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 13/05/25.
//

import Foundation

extension UsersViewController: UsersDelegate{
    
    
    func didReceiveUsers(users: [User]) {
        print("se ejecuto el delegado de users")
        self.users = users
        cvUsers.reloadData()
    }
    
    func didOccurError(error: any Error) {
        //aqui se maneja el error q haya ocurrido (mostrar alerta o mensaje en el collection que no se pudo cargar los usuarios)
    }
    
    
    
    
}
