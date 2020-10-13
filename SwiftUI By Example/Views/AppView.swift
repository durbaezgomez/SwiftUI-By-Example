//
//  AppView.swift
//  SwiftUI By Example
//
//  Created by Dominik Urbaez Gomez on 13/10/2020.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            MenuListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
                }
            
            OrderView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Order")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        AppView().environmentObject(order)
    }
}
