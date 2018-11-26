//
//  APIController.swift
//  MovileNext
//
//  Created by Matheus on 21/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class APIController {
    static var shared = APIController()
    
    private func urlString(searchText: String) -> URL {
        //evitar espaços
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let urlString = String(format: "https://itunes.apple.com/search?media=movie&entity=movie&term=%@", encodedText)
        
        let url = URL(string: urlString)!
        
        return url
    }
    
    private func parse(data: Data) -> [MovieFromAPI] {
        do {
            let deconder = JSONDecoder()
            let result = try deconder.decode(MoviesResult.self, from: data)
            return result.results
        } catch {
            print(error)
            return []
        }
    }
    
    func search(_ term: String) -> Observable<[MovieFromAPI]> {
        let url = urlString(searchText: term)
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        return session.rx.data(request: request).map { self.parse(data: $0) }
    }
}
