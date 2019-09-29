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
    
    var pay: BraspagPayProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pay = BraspagPay.createInstance(currencyCode: "BRL",
                                        countryCode: "BR",
                                        merchantId: "merchant.com.jnazario.digital-jef",
                                        viewDelegate: self)
        
        btnPay.addTarget(self, action: #selector(makePayment), for: .touchUpInside)
    }
    
    @objc func makePayment(_ sender: UIButton) {
        pay.makePayment(itemDescription: "Meu produto", amount: 150.30)
    }
}

extension ViewController: BraspagViewControllerProtocol {
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    func presentPayment(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func dismissPayment() {
        dismiss(animated: true, completion: nil)
    }
}
