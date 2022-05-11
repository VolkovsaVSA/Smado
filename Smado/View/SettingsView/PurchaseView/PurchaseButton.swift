//
//  PurchaseButton.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI
import StoreKit

struct PurchaseButton: View {
    @EnvironmentObject private var storeManager: StoreManager
    
    let product: Product
    
    var body: some View {
        Button {
            Task.init {
                try await storeManager.purchase(product)
            }
        } label: {
            VStack(alignment: .center, spacing: 4) {
                Text("\(product.displayPrice) / \(IAPProducts(rawValue: product.id) != nil ? IAPProducts(rawValue: product.id)!.localizedPeriod() : "n/a")")
                    .fontWeight(.medium)
                
                if storeManager.transactions.contains(where: { $0.productID == product.id }),
                   let trans = storeManager.transactions.filter({$0.productID == product.id}).last,
                   let expirationDate = trans.expirationDate
                {
                    Text("You have this subscription until \(expirationDate.formatted(date: .numeric, time: .omitted))")
                        .font(.system(size: 12, weight: .thin, design: .default))
                }
                
            }
            .frame(width: 250, height: 40, alignment: .center)
        }
        .buttonStyle(.borderedProminent)
        .foregroundColor(.primary)
        .tint(Color(UIColor.tertiarySystemBackground))
        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
        .disabled(storeManager.transactions.contains(where: { $0.productID == product.id }))
    }
}

