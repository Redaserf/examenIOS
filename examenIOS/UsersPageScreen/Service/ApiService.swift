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
    
    
    func getUsers(gender: Gender = .Default, completion: @escaping(Result<[User], ApiError>) -> Void){
        if let url = URL(string: "\(baseUrl)?results=50&gender=\(gender.rawValue)") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 20
            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                print("se mando la request")
                
                var apiError = ApiError(message: "Ocurrio un error inesperado", code: -1)

                                                
                if let error = error {
                    print(error)
                    apiError.message = error.localizedDescription
                    completion(.failure(apiError))
                    return
                }
                
                guard let data = data else {
                    apiError.message = "No se recibieron datos"
                    completion(.failure(apiError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                print("Estatus code de la respuesta:")
                print(httpResponse.statusCode)
                                
                if httpResponse.statusCode == 200 {
                    do {
                        let decodedResponse = try JSONDecoder().decode(UsersApiResponse.self, from: data)
                        print(decodedResponse.results)

                        completion(.success(decodedResponse.results))
                        //                        let users = decodedResponse.results
//                        print("Usuarios recibidos: \(users.count)")
                    } catch {
                        print(error)
                        print("Error al procesar los datos: \(error.localizedDescription)")
                        apiError.message = error.localizedDescription
                        completion(.failure(apiError))                    }
                }else {
                    
                    apiError.code = httpResponse.statusCode
                    switch httpResponse.statusCode {
                        case 404:
                            
                            apiError.message = "No se encontro el recurso"
                        
                        case 500:
                        
                            apiError.message = "Ocurrio un error en el servicio, reintentar mas tarde."
                        
                        case 429:
                            
                            apiError.message = "Demasiadas peticiones, intente en unos momentos."
                            
                        default:
                            apiError.message = error?.localizedDescription ?? apiError.message
                    }
                    
                    completion(.failure(apiError))
                    
                }
            }
            
            task.resume()
        } else {
            print("La URL no es válida")
            completion(.failure(ApiError(message: "La URL no válida", code: -1)))
        }

    }


    
}
