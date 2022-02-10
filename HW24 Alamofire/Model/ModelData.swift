//
//  ModelData.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import Foundation
import Alamofire
import Combine

final class ModelData: ObservableObject {
    @Published var characters = [Character]()
    @Published var searchText = ""
    @Published var showingAlert = false
    @Published var alertType: AlertType? = nil

    var publisher: AnyCancellable?
    var urlMarvel: URL?

    enum AlertType: String {
        case connection = "Похоже, проблема с интернетом"
        case url = "Проблема с получением данных"
        case token = "Проблема с доступом к данным"
    }
    
    fileprivate func getCharacterList(from urlMarvel: URL, clear: Bool = true) {
        let request = AF.request(urlMarvel)
        request.responseDecodable(of: MarvelResponse.self) { [self] data in
            guard let item = data.value?.data.results else {
                alertType = .connection
                showingAlert = true
                characters.removeAll()
                return
            }
            if clear {
                characters = item
            } else {
                characters.append(contentsOf: item)
            }
        }
    }
    
    init() {
        urlMarvel = makeRequestUrl(domain: MarvelAccount.serverURL,
                                   path: MarvelAccount.requestURL,
                                   queryItems: nil)
        
        loadData()
        
        publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [self] str in
                let url: URL?
                if !self.searchText.isEmpty {
                    url = makeRequestUrl(domain: MarvelAccount.serverURL,
                                         path: MarvelAccount.requestURL,
                                         queryItems: [URLQueryItem(name: "nameStartsWith", value: str)]
                    )
                } else {
                    url = urlMarvel
                }
                if let url = url {
                    getCharacterList(from: url)
                }
            })
    }
    
    func loadData(offset: Bool = false) {
        alertType = nil
        let url: URL?
        if !offset {
            url = urlMarvel
        } else {
            url = makeRequestUrl(domain: MarvelAccount.serverURL,
                                 path: MarvelAccount.requestURL,
                                 queryItems: [URLQueryItem(name: "offset", value: String(characters.count))]
            )
        }
        if let url = url {
            getCharacterList(from: url, clear: !offset)
        }
    }
    
    func loadMoreIfNeeded(_ item: Character) {
        if item == characters.last {
            loadData(offset: true)
        }
    }
    
    private func makeRequestUrl(domain: String, path: String, queryItems: [URLQueryItem]?) -> URL? {
        guard let baseURL = URL(string: domain) else {
            alertType = .url
            showingAlert = true
            return nil
        }
        let requestURL: URL
        requestURL = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        
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
            alertType = .token
            showingAlert = true
            return nil
        }
        return newRequestURL
    }
    
    func makeMarvelRequestUrl(from path: String) -> String {
        makeRequestUrl(domain: path, path: "", queryItems: nil)?.absoluteString ?? ""
    }
}
