//
//  ContentView.swift
//  HW24 Alamofire
//
//  Created by Denis Aganov on 02.02.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 237/255.0, green: 29/255.0, blue: 36/255.0))
                    .ignoresSafeArea(edges: [.top])
                    .frame(height: 70)
                Image("marvel")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.bottom,6)
            }
            
            CharacterList()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
