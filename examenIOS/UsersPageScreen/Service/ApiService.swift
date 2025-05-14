//
//  ApiService.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 12/05/25.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    let baseUrl: URL = URL(string: "https://randomuser.me/api/")!
    
    
    func getUsers(gender: Gender = .Default, completion: @escaping(Result<[User], Error>) -> Void){
        if let url = URL(string: "\(baseUrl)?results=50&gender=\(gender.rawValue)") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 20
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                print("se mando la request")
                                                
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"])))
                    return
                }
                                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        let decodedResponse = try JSONDecoder().decode(UsersApiResponse.self, from: data)
                        print(decodedResponse.results)

                        completion(.success(decodedResponse.results))
                        //                        let users = decodedResponse.results
//                        print("Usuarios recibidos: \(users.count)")
                    } catch {
                        print(error)
                        print("Error al procesar los datos: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
            }
            
            task.resume()
        } else {
            print("La URL no es válida")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "La URL no es válida"])))
        }

    }


    
}
