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
        setupTable()
        getCurrencyList()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func getCurrencyList() {
        NetworkCallService.shared.makeNetworkCall(with: getCurrencyRequestModel()) { response in
            switch response.result {
            case .success(let data):
                guard data.success ?? false else {
                    self.showAlert(message: data.error?.info)
                    return
                }
                print(data.symbols?.CAD, "devAYZ")
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func getCurrencyRequestModel() -> NetworkCallModel<SymbolsListResponse> {
        return NetworkCallModel(
            endpoint: Endpoint.symbolsList.rawValue,
            responseType: SymbolsListResponse.self,
            requestMethod: .get,
            queryParameters: [
                "access_key" : PlistManager[.apiKey]
            ]
        )
    }
}

extension SelectCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = "USD"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
