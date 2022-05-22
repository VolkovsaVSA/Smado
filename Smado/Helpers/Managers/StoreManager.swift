//
//  StoreManager.swift
//  Debts
//
//  Created by Sergei Volkov on 18.12.2021.
//

import Foundation
import StoreKit

final class StoreManager: ObservableObject {
    static let shared = StoreManager()
    
    enum PurchaseError: Error {
        case failed, cancelled, pending, userCannotMakePayments, purchaseException
    }
    
    @Published private(set) var products: [Product]?
    @Published private(set) var transactions = Set<Transaction>()
    private var transactionListener: Task<Void, Error>? = nil
    
    
    init() {
        transactionListener = handleTransactions()
        Task {
            try? await loadProducts()
        }
    }
    
    deinit { transactionListener?.cancel() }
    
    @MainActor public func requestProductsFromAppStore(productIds: Set<String>) async -> [Product]? {
        try? await Product.products(for: productIds)
    }
    
    @MainActor public func purchase(_ product: Product) async throws -> Transaction? {
        
        guard AppStore.canMakePayments else { throw PurchaseError.userCannotMakePayments }
        guard let result = try? await product.purchase() else { throw PurchaseError.purchaseException }

        switch result {
            case .pending:
                throw PurchaseError.pending
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await transaction.finish()
                return transaction
            case .userCancelled:
                throw PurchaseError.cancelled
            @unknown default:
                assertionFailure("Unexpected result")
                throw PurchaseError.failed
        }

    }
    
    @MainActor private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
            case .unverified:
                UserDefaults.standard.set(false, forKey: UDKeys.fwu)
                UserDefaults.standard.set(false, forKey: UDKeys.fw)
                throw PurchaseError.failed
            case .verified(let safe):
//                transactions = []
                if let trans = safe as? Transaction {
                    if trans.productID == IAPProducts.Smado01MonthUnlimited.rawValue ||
                        trans.productID == IAPProducts.Smado12MonthUnlimited.rawValue {
                        UserDefaults.standard.set(true, forKey: UDKeys.fwu)
                        UserDefaults.standard.set(true, forKey: UDKeys.fw)
                    } else {
                        UserDefaults.standard.set(true, forKey: UDKeys.fw)
                        UserDefaults.standard.set(false, forKey: UDKeys.fwu)
                    }
                    transactions.insert(trans)
                }
//
//                print("---------------------------")
//                print(transactions.description)
//                print("===========================")
                return safe
        }
    }

    private func handleTransactions() -> Task<Void, Error> {
        Task.detached {
            for await result in Transaction.updates {
                let transaction = try await self.checkVerified(result)
                await transaction.finish()
            }
        }
    }
    
    @MainActor private func isPurchased(_ productID: String) async throws -> Bool {
        guard let result = await Transaction.currentEntitlement(for: productID) else {
            return false
        }
        let transaction = try checkVerified(result)

        return transaction.revocationDate == nil
        && !transaction.isUpgraded
    }
    
    @MainActor func loadProducts() async throws {
        Task.init {
            products = await requestProductsFromAppStore(productIds: Set(IAPProducts.allCases.compactMap {$0.rawValue}))?.sorted(by: {$0.price < $1.price})
            if let prods = products {
                for product in prods {
                    let _ = try? await isPurchased(product.id)
                }
            }

        }
    }
   
}

extension StoreManager {
    func calcPriceToMonth(product: Product) -> String {
        guard let subscription = product.subscription else {return ""}
        var subscriptionPeriod: Int = 0
        
        switch subscription.subscriptionPeriod.unit {
            case .day:
                break
            case .week:
                break
            case .month:
                subscriptionPeriod = subscription.subscriptionPeriod.value
            case .year:
                subscriptionPeriod = 12
            @unknown default:
                break
        }

        let monthPrice = product.price / Decimal(subscriptionPeriod)
        return monthPrice.formatted(.currency(code: Locale.current.currencyCode ?? "USD"))
    }
    func calcSave(product: Product, baseProduct: Product) -> String {
        guard let subscription = product.subscription else {return ""}
//        guard let monthPrice = products?.first?.price else {return ""}
        let monthPrice = baseProduct.price
        var subscriptionPeriod: Int = 0
        
        switch subscription.subscriptionPeriod.unit {
            case .day:
                break
            case .week:
                break
            case .month:
                subscriptionPeriod = subscription.subscriptionPeriod.value
            case .year:
                subscriptionPeriod = 12
            @unknown default:
                break
        }

        let fullMonthlyCost = monthPrice * Decimal(subscriptionPeriod)
        let save = (fullMonthlyCost - product.price) / fullMonthlyCost
        
        return Int(Double(truncating: save as NSNumber) * 100).formatted(.percent)
    }
}


enum IAPProducts: String, CaseIterable {
    case SmadoBackup1Month
    case SmadoBackup6Month
    case SmadoBackup12Month
    case Smado01MonthUnlimited
    case Smado12MonthUnlimited
    
    func localizedPeriod() -> String {
        switch self {
            case .SmadoBackup1Month:
                return NSLocalizedString("month", comment: "localizedPeriod")
            case .SmadoBackup6Month:
                return NSLocalizedString("6 months", comment: "localizedPeriod")
            case .SmadoBackup12Month:
                return NSLocalizedString("12 months", comment: "localizedPeriod")
            case .Smado01MonthUnlimited:
                return NSLocalizedString("month", comment: "localizedPeriod")
            case .Smado12MonthUnlimited:
                return NSLocalizedString("12 months", comment: "localizedPeriod")
        }
    }
}
