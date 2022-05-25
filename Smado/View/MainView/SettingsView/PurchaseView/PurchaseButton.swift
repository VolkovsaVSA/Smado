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
    @Environment(\.colorScheme) var colorScheme
    
    let product: Product
    
    var body: some View {
        Button {
            Task.init {
                try await storeManager.purchase(product)
            }
        } label: {
            VStack(alignment: .center, spacing: 2) {
                Text(product.displayName)
                    .font(.system(size: 14, weight: .thin, design: .default))
                Text("\(product.displayPrice) / \(IAPProducts(rawValue: product.id) != nil ? IAPProducts(rawValue: product.id)!.localizedPeriod() : "n/a")")
                    .font(.system(size: 14, weight: .medium, design: .default))
                
                if storeManager.transactions.contains(where: { $0.productID == product.id }),
                   let trans = storeManager.transactions.filter({$0.productID == product.id}).last,
                   let expirationDate = trans.expirationDate
                {
                    Text("You have this subscription until \(expirationDate.formatted(date: .numeric, time: .omitted))")
                        .font(.system(size: 10, weight: .thin, design: .default))
                }
                
            }
            .frame(width: 250, height: 44, alignment: .center)
        }
        .buttonStyle(.borderedProminent)
        .foregroundColor(.primary)
        .tint(Color(UIColor.tertiarySystemBackground))
        .shadow(color: storeManager.transactions.contains(where: { $0.productID == product.id }) ? .clear : colorScheme == .dark ? .clear : .black.opacity(0.2), radius: 6, x: 0, y: 3)
        .disabled(storeManager.transactions.contains(where: { $0.productID == product.id }))
    }
}

