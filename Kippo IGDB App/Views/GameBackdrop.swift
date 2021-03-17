//
//  GameBackdrop.swift
//  Kippo IGDB App
//
//  Created by Victor Ren on 2021-03-16.
//

import SwiftUI

struct GameBackdrop: View {
    
    let game: Game
    @ObservedObject var imageLoader = ImageLoader()
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 2)
            Text(game.name)
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.game.backdropURL)
        }
    }
}

struct GameBackdrop_Previews: PreviewProvider {
    static var previews: some View {
        GameBackdrop(game: Game.stubbedGame)
    }
}
