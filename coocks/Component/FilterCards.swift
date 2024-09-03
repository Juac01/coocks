//
//  FilterCards.swift
//  coocks
//
//  Created by ALINE FERNANDA PONZANI on 03/09/24.
//

import SwiftUI

struct FilterCards: View {
    @State private var name: String = "Default Name"
    @State private var urlImage: String? = nil
    @State private var image: String? = nil
    var body: some View {
        VStack{
            if urlImage? != nil{
                VStack {
                    AsyncImage(url: URL(string:urlImage)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFill()
                    .frame(width: 340, height: 330)
                    .cornerRadius(/*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/)
                }
            } else {
                VStack{
                    Image(image).resizable().scaledToFill()
                }
                .padding(.all, 25.0)
                .frame(width: 90.0, height: 95.0)
                .cornerRadius(20.0)
                .shadow(radius: 5)
            }
            Text(name)
                .font(.footnote)
        }
    }
}

#Preview {
    FilterCards()
}
