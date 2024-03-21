//
//  DataController-StoreKit.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 25.11.2023.
//

import Foundation
import StoreKit

extension DataController {
    /// The product ID for our premium unlock.
    static let unlockPremiumProductID = "me.gurbanova.julia.Portfolio.premiumUnlock"

    /// Loads and saves whether our premium unlock has been purchased.
    var fullVersionUnlocked: Bool {
        get {
            defaults.bool(forKey: "fullVersionUnlocked")
        }

        set {
            defaults.set(newValue, forKey: "fullVersionUnlocked")
        }
    }

    /// Checks existing entitlements and watches for transactions.
    func monitorTransactions() async {
        // Check for previous purchases.
        for await entitlement in Transaction.currentEntitlements {
            if case let .verified(transaction) = entitlement {
                await finalize(transaction)
            }
        }

        // Watch for future transactions coming in.
        for await update in Transaction.updates {
            if let transaction = try? update.payloadValue {
                await finalize(transaction)
            }
        }
    }

    /// Triggers the purchase flow.
    /// If purchasing the product was a success, reads the transaction out,
    /// and sends it onto the finalize() method to handle content unlocking.
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        if case let .success(validation) = result {
            try await finalize(validation.payloadValue)
        }
    }

    /// Handles the transactions, unlocks content, and handles refunds.
    @MainActor
    func finalize(_ transaction: Transaction) async {
        if transaction.productID == Self.unlockPremiumProductID {
            objectWillChange.send()
            fullVersionUnlocked = transaction.revocationDate == nil
            await transaction.finish()
        }
    }

    @MainActor
    func loadProducts() async throws {
        guard products.isEmpty else { return }

        try await Task.sleep(for: .seconds(0.2))
        products = try await Product.products(for: [Self.unlockPremiumProductID])
    }
}
