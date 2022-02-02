//
//  CharacterImage.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct CharacterImage: View {
    var character: Character
    
    var body: some View {
        character.smallImage
            .resizable()
            .foregroundColor(Color(uiColor: .quaternarySystemFill))
            .frame(width: 80, height: 60)
            .cornerRadius(4)
    }
}

struct CharacterImage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterImage(character: charactersExample[0])
    }
}
