//
//  ContentView.swift
//  Kippo IGDB App
//
//  Created by Victor Ren on 2021-03-16.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0.02, green: 0.08, blue: 0.25, alpha: 1)
    }
    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                        .font(Font.title.weight(.bold))
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .font(Font.title.weight(.bold))
                }
            FavouritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                        .font(Font.title.weight(.bold))
                }
        }.accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
