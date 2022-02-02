//
//  CharacterRow.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character
    
    var body: some View {
        HStack {
            character.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(character.name)
            
            Spacer()
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacterRow(character: charactersExample[0])
            CharacterRow(character: charactersExample[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
