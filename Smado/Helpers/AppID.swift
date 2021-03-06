//
//  AppID.swift
//  Neslis
//
//  Created by Sergey Volkov on 27.12.2020.
//

import Foundation

enum AppId {
    private static let appID = "1620114576"
    static let appUrl = URL(string: "itms-apps://itunes.apple.com/app/id" + AppId.appID)
    static let feedbackEmail = "smado@vsa.su"
    static let developerUrl = URL(string: "https://apps.apple.com/developer/sergei-volkov/id1385708952")
    static let displayName = Bundle.main.infoDictionary?.filter({ $0.key == "CFBundleDisplayName" }).first?.value as? String
    static let standartEula = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")
    static let privacyPolicy = URL(string: "https://pages.flycricket.io/smado/privacy.html")
}
