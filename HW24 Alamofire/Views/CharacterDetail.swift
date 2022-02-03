//
//  CharacterDetail.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct CharacterDetail: View {
    var character: Character
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: character.largeImagePath)) { image in
                    image.resizable()
                    image.aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200, alignment: .center)
                .clipped()
                .cornerRadius(8)
                
                Capsule()
                    .foregroundColor(.black.opacity(0.4))
                    .frame(width: 36, height: 5)
                    .padding(.top, 8)
            }
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(character.name)
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("Комиксов: \(character.comics.available)")
                        .padding(.bottom)
                        .font(.subheadline)
                    
                    Text(character.description.isEmpty ? "No description" : character.description)
                }
                .foregroundColor(character.isImageExist ? .black : .white)
                .padding(.horizontal)
            }
        }
        .background(
            VStack(spacing: 0) {
                if character.isImageExist {
                    AsyncImage(url: URL(string: character.largeImagePath)) { image in
                        image.blur(radius: 100)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    RadialGradient(gradient: Gradient(colors: [.red, .black]),
                                   center: .center,
                                   startRadius: 2,
                                   endRadius: 600)
                }
            }
        )
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: charactersExample[1])
    }
}
