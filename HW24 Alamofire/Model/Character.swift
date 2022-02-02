//
//  Character.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct Characters: Decodable {
    var characters: [Character]
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

var charactersExample = [
    Character(id: 1011334,
              name: "3-D Man",
              description: "",
              thumbnail: Character.ImageURL(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
             ),
    Character(id: 1017100,
              name: "A-Bomb (HAS)",
              description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
              thumbnail: Character.ImageURL(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16")
             )
]
