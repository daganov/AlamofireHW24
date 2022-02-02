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
            CharacterImage(character: character)
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                    .lineLimit(1)
                Text("Комиксов: \(character.comics.available)")
                    .font(.subheadline)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
            
            Spacer()
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacterRow(character: charactersExample[0])
                .preferredColorScheme(.dark)
            CharacterRow(character: charactersExample[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
