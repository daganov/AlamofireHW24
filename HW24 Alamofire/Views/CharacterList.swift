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
        NavigationView {
            VStack {
                if modelData.alertType != nil {
                    Label("Проблемы с получением данных", systemImage: "wifi.slash")
                    
                    Button("Обновить") {
                        modelData.loadData()
                    }
                    .padding(8)
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Spacer()
                } else {
                    List(modelData.characters, id: \.id) { character in
                        CharacterRow(character: character)
                            .onAppear {
                                modelData.loadMoreIfNeeded(character)
                            }
                    }
                    .navigationTitle("Characters")
                    .searchable(text: $modelData.searchText,
                                placement: .navigationBarDrawer(displayMode: .automatic),
                                prompt: "Найти супергероя"
                    )
                }
            }
        }
        .alert(isPresented: $modelData.showingAlert) {
            Alert(title: Text(modelData.alertType?.rawValue ?? ""))
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            .environmentObject(ModelData())
    }
}
