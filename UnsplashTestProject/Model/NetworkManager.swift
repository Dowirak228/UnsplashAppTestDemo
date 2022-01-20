//
//  NetworkManager.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 18/01/22.
//

import UIKit

struct NetworkManager {
    
    func fetchPhotos(query: String, completion: @escaping (ImageModel) -> ()) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(query)&client_id=UYtVivSdch5Q6oR0QW05vXb18e8ibqCmDTx20mMnxbg"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let image = try jsonDecoder.decode(ImageModel.self, from: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}



