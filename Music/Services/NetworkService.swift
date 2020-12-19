//
//  NetworkService.swift
//  Music
//
//  Created by ivan on 18.12.2020.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": "\(searchText)",
                          "limit":"50",
                          "media":"music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (dataResponse) in
            if let error = dataResponse.error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print(objects)
                completion(objects)
                
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
}
