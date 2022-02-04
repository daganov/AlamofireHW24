//
//  Character.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct MarvelResponse: Decodable {
    let code: Int
    let data: Characters    
}

struct Characters: Decodable {
    let results: [Character]
}

struct Character: Decodable, Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: ImageURL
    let comics: Comics

    struct ImageURL: Decodable {
        let path: String
        let `extension`: String
    }
    
    struct Comics: Decodable {
        let available: Int
    }
    
    var smallImagePath: String {
        "\(thumbnail.path)/landscape_small.\(thumbnail.extension)"
    }
    var largeImagePath: String {
        "\(thumbnail.path)/detail.\(thumbnail.extension)"
    }
    // API Documentation https://developer.marvel.com/documentation/images
    
    var isImageExist: Bool {
        !thumbnail.path.contains("image_not_available")
    }
}

var charactersExample = [
    Character(id: 1011334,
              name: "3-D Man",
              description: "",
              thumbnail: Character.ImageURL(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                extension: "jpg"
              ),
              comics: Character.Comics(available: 12)
             ),
    Character(id: 1017100,
              name: "A-Bomb (HAS)",
              description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
              thumbnail: Character.ImageURL(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                extension: "jpg"
              ),
              comics: Character.Comics(available: 7)
             )
]
