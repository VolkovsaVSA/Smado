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
            HStack {
                Text("Days before deadline")
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                Toggle("01", isOn: $notifToday)
                Toggle("07", isOn: $notifWeek)
                Toggle("30", isOn: $notifMonth)
            }
            .toggleStyle(.button)
            .newDocSectionStyle()
            
        }
        .ignoresSafeArea()
        .listRowSeparator(.hidden)
    }
}
