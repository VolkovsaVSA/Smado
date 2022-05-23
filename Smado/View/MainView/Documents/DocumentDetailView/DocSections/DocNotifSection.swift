//
//  DocNotifSection.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI

struct DocNotifSection: View {
    
    @Binding var notifToday: Bool
    @Binding var notifWeek: Bool
    @Binding var notifMonth: Bool
    
    var body: some View {
        Section(header: Text("Notification")) {
            
            GroupBox {
                HStack {
                    Text("Days before deadline")
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.75)
//                        .font(.system(size: 15, weight: .thin, design: .default))
                    Spacer()
                    Toggle("01", isOn: $notifToday)
    //                    .tint(.red)
                    Toggle("07", isOn: $notifWeek)
    //                    .tint(.yellow)
                    Toggle("30", isOn: $notifMonth)
                }
                .toggleStyle(.button)
            }
            .groupBoxStyle(DocInfSectionStyle())
    
        }
        .listRowSeparator(.hidden)
    }
}
