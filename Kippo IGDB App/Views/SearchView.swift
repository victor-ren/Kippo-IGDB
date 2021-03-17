//
//  SearchBar.swift
//  Kippo IGDB App
//
//  Created by Victor Ren on 2021-03-16.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            VStack {
                SearchBar()
                EmptyStateView()
                Color.white
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "SEARCH GAMES"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator()
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.white))
    }
}
    
