//
//  CharacterList.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct CharacterList: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        List(modelData.characters, id: \.id) { character in
            CharacterRow(character: character)
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
    }
}
