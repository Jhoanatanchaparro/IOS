//
//  ContentView.swift
//  Memorize
//
//  Created by Jhonatan David Chaparro Alvarez on 5/06/25.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["⚽️", "🏀", "🏉", "🏐", "⚾️", "🏈", ]
    @State var emojiCount = 4
    var body: some View {
        VStack{
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100 ))]){
                        ForEach(emojis[0..<emojiCount], id: \.self){
                            emoji in CardView(content: emoji).aspectRatio(contentMode: .fit)
                        }
                }
            }
            .foregroundColor(.green)
            Spacer(minLength: 20)
            HStack{
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
            .padding(.horizontal)
            .foregroundColor(.green)
    }
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add : some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
        
    }
}
struct CardView: View {
    var content: String
    @State var isFaceup: Bool = true

    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceup{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceup = !isFaceup
        }
    }
}
struct ContentView_Previews: PreviewProvider{
        static var previews: some View{
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
    }
}
