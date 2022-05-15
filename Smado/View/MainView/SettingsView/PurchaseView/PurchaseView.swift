//
//  PurchaseView.swift
//  Smado
//
//  Created by Sergei Volkov on 20.04.2022.
//

import SwiftUI
import StoreKit

struct PurchaseView: View {
    @EnvironmentObject private var storeManager: StoreManager
    
    @State private var showTerms = false

    var body: some View {
        
        ScrollView {
            GradientLine()
            
            VStack {
                
                Text("Purchasing subscription you get backuping your data.")
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                
                if let products = storeManager.products {
                    if products.isEmpty {
                        Text("Error")
                    } else {
                        ForEach(products) { product in
                            PurchaseCell(product: product)
                        }
                        Spacer()
                    }
                } else {
                    Text("Error")
                }
                Spacer()
                
                Text("If you have problems with payment, then write to smado@vsa.su")
                    .font(.system(size: 14, weight: .thin, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Recurring billing. Cancel any time. If you choose to purchase a subscription, payment will be charged to your iTunes account and your account will be charged for renewal 24 hours prior to the end of the current period unless auto-renew is turned off. Auto-renewal is managed by the user and may be turned off at any time by going to your settings in the iTunes Store after purchase. Any unused portion of a free trial period will be forfeited when the user purchases a subscription.")
                    .font(.system(size: 12, weight: .thin, design: .default))
                Button("Terms & Privacy Policy") { showTerms = true }
                    .frame(maxHeight: 30)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 12))
                    .padding()
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
            }//Vstack
            .padding()
            
        }//zstack
        .background(Color.primary.colorInvert().ignoresSafeArea())
        .navigationTitle("Choose plan")
        
        .sheet(isPresented: $showTerms) {
            TermsConditions()
        }
    }
}
