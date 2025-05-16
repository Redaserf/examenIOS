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
        
        //si esta el label de error loo oculta al cargar los usuarios correctamente
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
            print("dismiss alert in errorOccur")
            self.cvUsers.backgroundView = lblError
            self.users = []
            self.cvUsers.reloadData()
            let alert = UIAlertController(title: "Ocurrio un error al cargar los usuarios", message: "\(error.message)", preferredStyle: .alert)
            
            
            let btnAccept = UIAlertAction(title: "Aceptar", style: .cancel)
            alert.addAction(btnAccept)
            
            self.present(alert, animated: true)
        }
    }
    
    func showLoadingAlert() {
        activityIndicator.startAnimating()
        
        
        alertLoadingUsers.view.addSubview(activityIndicator)

        let centerX = activityIndicator.centerXAnchor.constraint(equalTo: alertLoadingUsers.view.centerXAnchor)
        let centerY = activityIndicator.centerYAnchor.constraint(equalTo: alertLoadingUsers.view.centerYAnchor)

        alertLoadingUsers.view.addConstraint(centerX)
        alertLoadingUsers.view.addConstraint(centerY)
        
        self.ncTittle.leftBarButtonItem?.isEnabled = false
        self.ncTittle.rightBarButtonItem?.isEnabled = false
        
        present(alertLoadingUsers, animated: true)
    }
    
    func stopLoadingAlert() {
        //dismiss the alert with the activity indicator
        
        alertLoadingUsers.dismiss(animated: true) {
            print("dismiss alert in stopLoadingAlert")

            self.activityIndicator.stopAnimating()
            self.ncTittle.leftBarButtonItem?.isEnabled = true
            self.ncTittle.rightBarButtonItem?.isEnabled = true
        }
    }
    
    
}
