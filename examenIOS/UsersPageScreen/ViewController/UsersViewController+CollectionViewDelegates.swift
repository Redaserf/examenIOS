//
//  UsersViewController+CollectionViewDelegates.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 13/05/25.
//

import Foundation
import UIKit

extension UsersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User selected at: ", indexPath.row)
        
        let vcUserDetail = storyboardDestiny.instantiateViewController(identifier: "UserDetail") as! UserDetailViewController
        
        vcUserDetail.user = users[indexPath.row]
        
        self.navigationController?.pushViewController(vcUserDetail, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as! UserCollectionViewCell
        
        //CAMBIAR USERS POR USERS DEL VIEWMODEL
        //buscamos el usuario q esta recorriendo la coleccion
        let user = users[indexPath.row]

        //le mandamos el usuario para configurar la celda
        cell.setUpCell(user: user)
        
        return cell
    }
    
    
}
