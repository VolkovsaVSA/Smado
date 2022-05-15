//
//  FeedbackSection.swift
//  Debts
//
//  Created by Sergei Volkov on 13.12.2021.
//

import SwiftUI
import MessageUI

struct FeedbackSection: View {
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var showMail: Bool = false
    
    var body: some View {
        
        Section(header: Text("Feedback").fontWeight(.semibold).foregroundColor(.primary),
                footer:
                    HStack {
            Spacer()
            Text("\(Bundle.main.displayName) \(Bundle.main.appVersionShort) (\(Bundle.main.appBuild))")
                .font(.system(size: 12, weight: .thin, design: .default))
            Spacer()
        }
                    
        ) {
            
            VStack {
                FeedbackButton(buttonText: NSLocalizedString("Send email to the developer", comment: " "),
                               systemImage: "envelope",
                               disableButton: !MFMailComposeViewController.canSendMail(),
                               backgroundColor: .blue) {
                    if MFMailComposeViewController.canSendMail() { showMail.toggle() }
                }

                FeedbackButton(buttonText: NSLocalizedString("Rate the app", comment: " "),
                               systemImage: "star",
                               disableButton: false,
                               backgroundColor: .yellow) {
                    ConnectionManager.openUrl(openurl: AppId.appUrl)
                }
                
                FeedbackButton(buttonText: NSLocalizedString("Other applications", comment: " "),
                               systemImage: "apps.iphone.badge.plus",
                               disableButton: false,
                               backgroundColor: Color.indigo) {
                    ConnectionManager.openUrl(openurl: AppId.developerUrl)
                }
            }

        }
        
        .sheet(isPresented: $showMail) {
            MailView(result: $mailResult,
                     recipients: [AppId.feedbackEmail],
                     messageBody: NSLocalizedString("Feedback on application \"Smado\"", comment: " "))
        }
    }
    
}
