//
//  RecipeView.swift
//  coocks
//
//  Created by ALINE FERNANDA PONZANI on 29/08/24.
//

import SwiftUI

struct IconesView: View {
    var url: String
    var text: String
    var body: some View{
        VStack(){
            VStack{
                AsyncImage(url: URL(string:url)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.all, 12.0/*@END_MENU_TOKEN@*/)
            .frame(width: 90.0, height: 95.0)
            .background(Color.white)
            .cornerRadius(20.0)
            .shadow(radius: 5, x: 0, y: 5)
            Text(text)
                .font(.footnote)
        }
    }
}


struct RecipeView: View {
    let name: String
    let image: String
    let glass: String
    let preparo: String
    let ingredientes: [(String, String)]
    var body: some View {
        ScrollView{
        
        VStack(spacing: 16.0){
            AsyncImage(url: URL(string:image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .frame(width: 340, height: 330)
            .cornerRadius(/*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/)
            
            Text(name)
                .font(.title)
                .foregroundColor(Color("Principal"))
            
            //lista de ingredientes
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .center, spacing: 20.0){
                    ForEach(ingredientes, id: \.1) { (medida, ingredient) in
                        IconesView(url: "https://www.thecocktaildb.com/images/ingredients/\(ingredient).png", text: medida)
                    }
                }
                .padding(.leading, 20.0)
            }
            
            
            HStack(alignment: .top, spacing: 32.0){
                VStack{
                    Text("Glass")
                        .font(.title2)
                        .foregroundColor(Color("Principal"))
                    VStack{
                        Image(glass).resizable().scaledToFill()
                    }.padding(.all, 25.0)
                    .frame(width: 90.0, height: 95.0)
                    .cornerRadius(20.0)
                    .shadow(radius: 5)
                    Text(glass)
                        .font(.footnote)
                }
                VStack{
                    Text("Instructions")
                        .font(.title2)
                        .foregroundColor(Color("Principal"))
                    Text(preparo)
                        .font(.body)
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.horizontal, 17.0/*@END_MENU_TOKEN@*/)
            Spacer()
        }
        .scrollContentBackground(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
    }
    }
}

#Preview {
    RecipeView(name: "Margarita", image: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg", glass: "Cocktail glass", preparo: "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.", ingredientes: [("1", "Tequila"),("1", "Triple sec"),("1", "Lime juice"),("to taste", "Salt")])
}
