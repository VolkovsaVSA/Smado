//
//  ConnectionManager.swift
//  Debts
//
//  Created by Sergei Volkov on 10.07.2021.
//

import UIKit

struct ConnectionManager {
//    private static func convertToRightPhoneNumber(number: String)->String {
//        let filtredUnicodeScalars = number.unicodeScalars.filter {CharacterSet.decimalDigits.contains($0)}
//        return String(String.UnicodeScalarView(filtredUnicodeScalars))
//    }
    
    static func openUrl(openurl: URL?) {
        if let url = openurl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

//    static func makeACall(number: String) {
//        if let url = URL(string: "tel://\(convertToRightPhoneNumber(number: number))"), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
//        }
//    }
//    static func share(selectedDebt: DebtCD) {
//        let status = selectedDebt.localizeDebtStatus
//        let recipients = String(localized: "\(status) \(selectedDebt.debtor?.fullName ?? "")") as AnyObject
//        let phone = String(localized: "Phone number: \(selectedDebt.debtor?.phone ?? "")") as AnyObject
//        let amountDebt = String(localized: "Debt: \(CurrencyViewModel.shared.debtBalanceFormat(debt: selectedDebt))") as AnyObject
//        let returnDate = String(localized: "Return date: \(selectedDebt.localizeEndDateShort)") as AnyObject
//        let messageToShare = String(localized: "\(selectedDebt.debtor?.fullName ?? "") you have delayed payment! Pay urgently!")
//
//        let textToShare = """
//\(recipients)
//\(phone)
//\(amountDebt)
//\(returnDate)
//
//\(messageToShare)
//"""
//
//        let shareActivity = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
//        if let vc = UIApplication.shared.windows.first?.rootViewController {
//            shareActivity.popoverPresentationController?.sourceView = vc.view
//            //Setup share activity position on screen on bottom center
//            shareActivity.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height, width: 0, height: 0)
//            shareActivity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
//            vc.present(shareActivity, animated: true, completion: nil)
//
//
//        }
//    }
}
