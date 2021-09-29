//
//  APIManager.swift
//  MplusSoft Machine test
//
//  Created by Somnath on 25/09/21.
//

import Foundation

class NetworkManager: NSObject {
    
    var categories = [ProductCategoryList]()

    //MARK:- GETServices
    func GETServices(url: String, completionHandler: @escaping(_ categories: [ProductCategoryList]) -> Void) {
        if let url = URL(string: urlString)
            {
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    if let welcome = try? JSONDecoder().decode(ProductCategory.self, from: unwrappedData)
                    {
                        self.categories = welcome.productCategoryList
                        
                        print(unwrappedData)
                        completionHandler(self.categories)

                    }
                }
                
            }
            
            dataTask.resume()
        }
    }
    
    // MARK:- POSTService
    func POSTService(url: String, postString: String, completionHandler: @escaping(_ categories: PostGetPostList) -> Void) {
        

        var urlRequest = URLRequest(url: URL(string: url)!)
        
        do {
            urlRequest.httpBody = postString.data(using: .utf8)
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"

            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let error = error {
                           print("Error took place \(error)")
                           return
                       }
                
                       // Convert HTTP Response Data to a String
                       if let data = data, let dataString = String(data: data, encoding: .utf8) {
                           print("Response data string:\n \(dataString)")
                       }
                
                guard let data = data else {return}
                       do{
                           let todoItemModel = try JSONDecoder().decode(PostGetPostList.self, from: data)

                        completionHandler(todoItemModel)
                       }catch let jsonErr{
                           print(jsonErr)
                      }
            }

            
            task.resume()
        }
    }
    
}
