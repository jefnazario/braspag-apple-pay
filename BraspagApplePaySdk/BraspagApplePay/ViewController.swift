//
//  ViewController.swift
//  BraspagApplePay
//
//  Created by Jeferson Nazario on 28/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import UIKit
import PassKit
import BraspagApplePaySdk

class ViewController: UIViewController {
    
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var btnPayAddress: UIButton!
    
    var pay: BraspagApplePayProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pay = BraspagApplePay.createInstance(merchantId: "merchant.com.jnazario.digital-jef",
                                             viewDelegate: self)
        
        btnPay.addTarget(self,
                         action: #selector(makePaymentWithDefaultContactAddress),
                         for: .touchUpInside)
        
        btnPayAddress.addTarget(self,
                                action: #selector(makePaymentWithRequiredBillingShippingAddress),
                                for: .touchUpInside)
    }
    
    @objc func makePaymentWithDefaultContactAddress(_ sender: UIButton) {
        pay.makePayment(itemDescription: "Meu produto", amount: 150.30, contactInfo: nil)
    }
    
    @objc func makePaymentWithRequiredBillingShippingAddress(_ sender: UIButton) {
        
        let billingAddress = AddressInfo(street: "Rua A", city: "Cidade A", state: "Estado A", postalCode: "29100000")
        let contact = ContactInfo(firstName: "Jeferson",
                                  lastName: "F Nazario",
                                  email: "jeferson@teste.com",
                                  phoneNumber: "987654321",
                                  billingAddress: billingAddress)
        
        pay.makePayment(itemDescription: "Meu produto com endereço", amount: 2000, contactInfo: contact)
    }
}

extension ViewController: BraspagApplePayViewControllerDelegate {
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    func presentAuthorizationViewController(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func dismissPaymentAuthorizationViewController() {
        dismiss(animated: true, completion: nil)
    }
}
