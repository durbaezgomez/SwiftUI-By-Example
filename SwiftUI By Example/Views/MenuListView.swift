//
//  ContentView.swift
//  SwiftUI By Example
//
//  Created by Dominik Urbaez Gomez on 13/10/2020.
//

import SwiftUI

struct MenuListView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            ItemRowView(item: item)
                        }
                    }
                }
                .navigationBarTitle("Menu")
                .listStyle(GroupedListStyle())
            }
        }
    }
}

struct MenuListView_Previews: PreviewProvider {
    static var previews: some View {
        MenuListView()
    }
}
