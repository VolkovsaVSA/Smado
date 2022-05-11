//
//  FeedbackButton.swift
//  Debts
//
//  Created by Sergei Volkov on 11.07.2021.
//

import SwiftUI

struct FeedbackButton: View {
    
    let buttonText: String
    let systemImage: String
    @State var disableButton = false
    let backgroundColor: Color
    
    @State private var imageSize: CGFloat = 24
    
    var action: ()->()
    
    var body: some View {
        Button {
            action()
        } label: {
            
            HStack{
                SettingsIcon(systemName: systemImage, color: backgroundColor)
                VStack(alignment: .leading ,spacing: 0) {
                    Text(buttonText)
                    if disableButton {
                        Text("To send an email please configure email into settings iOS")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.system(size: 10, weight: .thin, design: .default))
                    }
                }
                Spacer()
            }
        }
        .disabled(disableButton)
        .buttonStyle(.plain)
    }
}

