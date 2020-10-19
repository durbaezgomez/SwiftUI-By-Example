//
//  CheckoutView.swift
//  SwiftUI By Example
//
//  Created by Dominik Urbaez Gomez on 13/10/2020.
//

import SwiftUI

enum PaymentType: String {
    case cash = "Cash"
    case card = "Credit Card"
    case points = "iDine Points"
}

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    
    static let paymentTypes: [PaymentType] = [.cash, .card, .points]
    @State private var paymentType: PaymentType = .cash
    
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    
    static let tipAmounts = [10, 15, 20, 25, 0]
    @State private var tipAmount = 1
    
    var body: some View {
        VStack {
            Section {
                Form {
                    Picker("How do you want to pay?", selection: $paymentType) {
                        ForEach(Self.paymentTypes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    Toggle(isOn: $addLoyaltyDetails.animation()) {
                        Text("Add iDine loyalty card")
                    }
                    if addLoyaltyDetails {
                        TextField("Enter your iDine ID", text: $loyaltyNumber)
                    }
                    Section(header: Text("Add a tip?")) {
                        Picker("Percentage:", selection: $tipAmount) {
                            ForEach(0 ..< Self.tipAmounts.count) {
                                Text("\(Self.tipAmounts[$0])%")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header:
                        Text("TOTAL: $100")
                    ) {
                        Button("Confirm order") {
                            // place the order
                        }
                    }
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
