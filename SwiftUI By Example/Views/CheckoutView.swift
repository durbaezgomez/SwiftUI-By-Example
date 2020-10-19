//
//  CheckoutView.swift
//  SwiftUI By Example
//
//  Created by Dominik Urbaez Gomez on 13/10/2020.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    @State private var paymentType = 0
    
    var body: some View {
        VStack {
            Section {
                VStack {
                    Text("How do you want to pay?")
                    Picker("", selection: $paymentType) {
                        ForEach(Self.paymentTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(width: 100, height: 100)
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        NavigationView {
            CheckoutView().environmentObject(order)
        }
    }
}
