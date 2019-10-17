//
//  BraspagApplePaySdkTests.swift
//  BraspagApplePaySdkTests
//
//  Created by Jeferson Nazario on 28/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import XCTest
import PassKit
@testable import BraspagApplePaySdk

class BraspagApplePaySdkTests: XCTestCase {

    var pay: BraspagApplePayProtocol!
    var showAuthorizationViewController: Bool = false
    var displayError: Bool = false
 
    fileprivate func createInstance() {
        pay = BraspagApplePaySpy.createInstance(currencyCode: "BRL",
                                                countryCode: "BR",
                                                merchantId: "merchant.com.jnazario.digital-jef",
                                                viewDelegate: self)
    }
    
    func testInstantiateSdkSuccessful() {
        createInstance()
        XCTAssertNotNil(pay)
    }
    
    func testInstantiateSdkNil() {
        XCTAssertNil(pay)
    }
    
    func testMakePaymentSuccessfulWithoutContactInfo() {
        createInstance()
        pay.makePayment(itemDescription: Products.successfulWithoutContactInfo.rawValue, amount: 1500, contactInfo: nil)
        
        XCTAssertTrue(showAuthorizationViewController)
    }
    
    func testMakePaymentWithoutContactInfoAndForbiddenPaymentNetworks() {
        createInstance()
        pay.makePayment(itemDescription: Products.forbiddenPaymentNetworks.rawValue, amount: 2500, contactInfo: nil)
        
        XCTAssertTrue(displayError)
    }
    
    func testMakePaymentWithoutContactInfoAndAllowedPaymentNetworks() {
        createInstance()
        pay.makePayment(itemDescription: Products.allowedPaymentNetworks.rawValue, amount: 2500, contactInfo: nil)
        
        XCTAssertTrue(showAuthorizationViewController)
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}

extension BraspagApplePaySdkTests: BraspagApplePayViewControllerDelegate {
    func displayAlert(title: String, message: String) {
        displayError = title == "Error"
    }
    
    func presentAuthorizationViewController(viewController: UIViewController) {
        showAuthorizationViewController = true
    }
    
    func dismissPaymentAuthorizationViewController() {
        print(#function)
    }
}
