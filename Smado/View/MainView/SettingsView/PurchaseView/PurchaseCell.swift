//
//  PurchaseCell.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI
import StoreKit

struct PurchaseCell: View {
    @EnvironmentObject private var storeManager: StoreManager
    
    let product: Product
    
    var body: some View {
        
        VStack {
            PurchaseButton(product: product)

            Group {
                if product.id != IAPProducts.SmadoBackup1Month.rawValue,
                   let period = IAPProducts(rawValue: product.id)
                {
                    Text("\(period.localizedPeriod()) at \(storeManager.calcPriceToMonth(product: product))/month. Save \(storeManager.calcSave(product: product))")
                        .font(.system(size: 14, weight: .light, design: .default))
                        .multilineTextAlignment(.center)
                } else {
                    Text(" ")
                        .font(.system(size: 1, weight: .light, design: .default))
                }
            }
            .padding(.bottom, 10)
        }
        
    }
    
}
