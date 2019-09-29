//
//  EasyPay.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 29/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import Foundation
import PassKit

@objc public class BraspagPay: NSObject, BraspagPayProtocol {

    var currencyCode, countryCode, merchantId: String!
    weak var delegate: BraspagViewControllerProtocol!
    
    @objc init(currencyCode: String = "BRL",
               countryCode: String = "BR",
               merchantId: String,
               delegate: BraspagViewControllerProtocol) {
        self.currencyCode = currencyCode
        self.countryCode = countryCode
        self.merchantId = merchantId
        self.delegate = delegate
    }
    
    public static func createInstance(currencyCode: String,
                                      countryCode: String,
                                      merchantId: String,
                                      viewDelegate: BraspagViewControllerProtocol) -> BraspagPay {
        return BraspagPay(currencyCode: currencyCode,
                       countryCode: countryCode,
                       merchantId: merchantId,
                       delegate: viewDelegate)
    }
    
    @objc public func makePayment(itemDescription: String, amount: Double) {
        let paymentItem = PKPaymentSummaryItem(label: itemDescription, amount: NSDecimalNumber(value: amount))
        let paymentNetworks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
        
        guard PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) else {
            delegate.displayAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
            return
        }

        let request = PKPaymentRequest()
        request.currencyCode = currencyCode
        request.countryCode = countryCode
        request.merchantIdentifier = merchantId
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.supportedNetworks = paymentNetworks
        request.paymentSummaryItems = [paymentItem]
        
        guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
            delegate.displayAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
            return
        }
        paymentVC.delegate = self
        delegate.presentPayment(viewController: paymentVC)
    }
}

extension BraspagPay: PKPaymentAuthorizationViewControllerDelegate {
    @objc public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        debugPrint(#function)
        delegate.dismissPayment()
    }
    
    // swiftlint:disable:next line_length
    @objc public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        debugPrint(#function)
        delegate.dismissPayment()
        delegate.displayAlert(title: "Success!", message: "The Apple Pay transaction was complete.")
    }
}
