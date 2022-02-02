//
//  Character.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct Characters: Decodable {
    let character: [Character]
}
struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ImageURL
    
    struct ImageURL: Decodable {
        let path: String
    }
}
