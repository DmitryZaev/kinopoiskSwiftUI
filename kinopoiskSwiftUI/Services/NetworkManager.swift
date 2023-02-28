//
//  NetworkManager.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 19.02.2023.
//

import Foundation
import Combine
import SwiftUI

class NetworkManager {
    
    let startUrsString = "https://api.kinopoisk.dev/movie?"
    
    func fetchMovie<T : Decodable>(name: String?, years: String?, rating: String?, sorting: Sorting?, movieId: Int?) -> AnyPublisher<T, Error> {
        
        guard let url = obtainURL(name: name,
                                  years: years,
                                  rating: rating,
                                  sorting: sorting,
                                  movieID: movieId)
        else { return Fail(error: NSError(domain: "Error: Bad URL", code: 400)).eraseToAnyPublisher()}
        
        return Future { promise in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    promise(.failure(error))
                    return
                }
                
                guard let data else { return }
                self.decode(from: data) { (model : T) in
                    promise(.success(model))
                }
            }.resume()
        }
        .eraseToAnyPublisher()
    }
    
    private func obtainURL(name: String?, years: String?, rating: String?, sorting: Sorting?, movieID: Int?) -> URL? {
        
        let token = obtainToken()
        var url = URL(string: "")
        var urlString = startUrsString
        
        if let name {
            urlString += "field=name&search=\(name)&"
            let urlForCheck = URL(string: urlString + "limit=500&isStrict=false&token=\(token)")
            
            if urlForCheck == nil {
                guard let codedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return url }
                urlString = startUrsString + "field=name&search=\(codedName)&"
            }
        }
        
        if let years {
            urlString += "field=year&search=\(years)&"
        }
        
        if let rating {
            urlString += "field=rating.kp&search=\(rating)&"
        }
        
        if let movieID {
            urlString += "field=id&search=\(String.init(describing: movieID))&"
        } else {
            if let sorting {
                urlString += "&sortField=\(sorting.sortField)&sortType=\(sorting.sortType)&"
            }
        }
        
        urlString += "limit=200&isStrict=false&token=\(token)"
        print(urlString)
        url = URL(string: urlString)
        
        return url
    }
    
    private func obtainToken() -> String {
        
        let path = Bundle.main.path(forResource: "Keys", ofType: "plist")
        guard let path = path else { return ""}
        let pathUrl = URL(fileURLWithPath: path)
        guard let keys = try? NSDictionary(contentsOf: pathUrl, error: ()) else { return ""}
        guard let token = keys["token"] as? String else { return ""}
        return token
    }
    
    private func decode<T : Decodable>(from data: Data, completion: @escaping (T) -> Void) {
        let decoder = JSONDecoder()
        do {
            let json = try decoder.decode(T.self, from: data)
            completion(json)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func openInKinopoisk(id: Int) {
        let stringID = String.init(describing: id)
        let urlString = "https://www.kinopoisk.ru/film/\(stringID)"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
