//
//  ViewController.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 26/03/2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var exchangeRateButton: UIButton!
    
    private var exchangeRateButtonTitle = "Mid-market exchange rate at {t}  "

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        exchangeRateButton.setTitle(exchangeRateButtonTitle, for: .normal)
    }


}

