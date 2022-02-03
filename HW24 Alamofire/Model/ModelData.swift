//
//  ModelData.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import Foundation
import Alamofire

final class ModelData: ObservableObject {
    @Published var characters = [Character]()

    init() {
        let url_marvel = makeRequestUrl(domain: MarvelAccount.serverURL,
                                        path: MarvelAccount.requestURL,
                                        queryItems: nil)
        let request = AF.request(url_marvel)
        request.responseDecodable(of: MarvelResponse.self) { [self] data in
            guard let item = data.value?.data.results else {
                fatalError("Couldn't load data in.")
            }
            characters = item
            // вызов обновления таблицы
        }
    }
    
    private func makeRequestUrl(domain: String, path: String, queryItems: [URLQueryItem]?) -> URL {
        guard let baseURL = URL(string: domain) else {
            fatalError("Cannot create URL.")
        }
        let requestURL: URL
        if path.isEmpty {
            requestURL = baseURL
        } else {
            requestURL = baseURL.appendingPathComponent(path)
        }
        
        // Marvel token
        let timestamp = String(NSDate().timeIntervalSince1970)
        let publicKey = MarvelAccount.publicKey
        let privateKey = MarvelAccount.privateKey
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5

        var queryItemsLocal = queryItems ?? [URLQueryItem]()
        queryItemsLocal.append(URLQueryItem(name: "ts", value: timestamp))
        queryItemsLocal.append(URLQueryItem(name: "apikey", value: publicKey))
        queryItemsLocal.append(URLQueryItem(name: "hash", value: hash))
        
        var urlComponents = URLComponents(string: requestURL.absoluteString)
        urlComponents?.queryItems = queryItemsLocal
        guard let newRequestURL = urlComponents?.url else {
            fatalError("Cannot create URL with query items.")
        }
        return newRequestURL
    }
    
    func makeMarvelRequestUrl(from path: String) -> String {
        makeRequestUrl(domain: path, path: "", queryItems: nil).absoluteString
    }
}
