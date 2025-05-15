//
//  UsersViewController+UsersDelegate.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 13/05/25.
//

import Foundation
import UIKit

extension UsersViewController: UsersDelegate{
    
    
    func didReceiveUsers(users: [User]) {
        print("se ejecuto el delegado de users")
        self.users = users
        cvUsers.reloadData()
        
        alertLoadingUsers.dismiss(animated: true) {
            self.ncTittle.leftBarButtonItem?.isEnabled = true
            self.ncTittle.rightBarButtonItem?.isEnabled = true
        }
        //ocultar el lblError al cargar los usuarios por si ocurre el 429
        
        //si esta el label de error,si los botones del navigationController estan deshabilitados habilitar y quitar el label del error
        if cvUsers.backgroundView != nil {
            cvUsers.backgroundView!.isHidden = true
        }
        
    }
    
    func didOccurError(error: ApiError) {
        //aqui se maneja el error q haya ocurrido (mostrar alerta o mensaje en el collection que no se pudo cargar los usuarios)
        
        //setear label en la collection view q no se pudieron cargar usuarios.
        
        let lblError = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))

         lblError.text = "No se pudieron cargar los usuarios. Intente de nuevo más tarde."
         lblError.textColor = .black
         lblError.numberOfLines = 0
         lblError.textAlignment = .center
         lblError.font = UIFont.systemFont(ofSize: 17, weight: .regular)
         lblError.sizeToFit()
         lblError.clipsToBounds = true
        
        alertLoadingUsers.dismiss(animated: true) {
            self.ncTittle.leftBarButtonItem?.isEnabled = true
            self.ncTittle.rightBarButtonItem?.isEnabled = true
            self.cvUsers.backgroundView = lblError
            self.users = []
            self.cvUsers.reloadData()
            let alert = UIAlertController(title: "Ocurrio un error al cargar los usuarios", message: "\(error.message)", preferredStyle: .alert)
            
            
            let btnAccept = UIAlertAction(title: "Aceptar", style: .cancel)
            alert.addAction(btnAccept)
            
            self.present(alert, animated: true)
        }
        
        
        //si se hicieron demasiadas peticiones bloquesar bvar button dentro del nc
//        if error.code == 429 {
//            ncTittle.leftBarButtonItem?.isEnabled = false
//            ncTittle.rightBarButtonItem?.isEnabled = false
//        }
        

    }
    
    
    
    
}
