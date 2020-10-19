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

enum PickupTime: String {
    case now = "Now"
    case evening = "Today evening"
    case tomorrowMorning = "Tomorrow morning"
}

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    
    static let paymentTypes: [PaymentType] = [.cash, .card, .points]
    @State private var paymentType: PaymentType = .cash
    
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    
    static let tipAmounts = [10, 15, 20, 25, 0]
    @State private var tipAmount = 1
    
    static let pickupTimes: [PickupTime] = [.now, .evening, .tomorrowMorning]
    @State private var pickupTime: PickupTime = .now
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    @State private var showingPaymentAlert = false
    
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
                    Picker("Pickup time?", selection: $pickupTime) {
                        ForEach(Self.pickupTimes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    Section(header:
                                Text("TOTAL: $\(totalPrice, specifier: "%.2f")")
                                .font(.largeTitle)
                    ) {
                        Button("Confirm order") {
                            self.showingPaymentAlert.toggle()
                        }
                    }
                }
                .alert(isPresented: $showingPaymentAlert) {
                    Alert(title: Text("Order confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%.2f") – thank you!"), dismissButton: .default(Text("OK")))
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
