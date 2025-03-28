//
//  SelectCurrencyViewController.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 28/03/2025.
//

import UIKit

enum SelectCurrencyFlow {
    case from
    case to
}

class SelectCurrencyViewController: UIViewController {

    // MARK: Views Outlet
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // MARK: Properties
    var currencyFlow: SelectCurrencyFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        switch currencyFlow {
        case .from:
            topLabel.text = "Convert From:"
        case .to:
            topLabel.text = "Convert To:"
        default:
            break
        }
    }
}
