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

protocol SelectCurrencyDelegate {
    func didSelectCurrency(_ currency: SingleCurrency)
}

class SelectCurrencyViewController: UIViewController {

    // MARK: Views Outlet
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    
    // MARK: Properties
    var currencyFlow: SelectCurrencyFlow?
    var filteredSymbols: [String: String]?
    
    var delegate: SelectCurrencyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        switch currencyFlow {
        case .from:
            toLabel.textColor = .systemGray5
        case .to:
            fromLabel.textColor = .systemGray5
        default:
            break
        }
        setupTable()
        cancelButton.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchBar.delegate = self
    }
    
    @objc func cancelClicked() {
        dismiss(animated: true)
    }
}

extension SelectCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredSymbols?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        guard let filteredSymbols = filteredSymbols else {
            cell.textLabel?.text = "N/A"
            return cell
        }
        cell.textLabel?.text = Array(filteredSymbols.values)[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let filteredSymbols = filteredSymbols else { return }
        let currencyCode = Array(filteredSymbols.keys)[indexPath.row]
        let curencyName = Array(filteredSymbols.values)[indexPath.row]
        dismiss(animated: true) {
            self.delegate?.didSelectCurrency(.init(code: currencyCode, name: curencyName))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}

extension SelectCurrencyViewController: UISearchBarDelegate {
    func searchSymbols(for searchText: String) {
        let symbolList = RealmManager.shared.retrieveObject(DataManager.self)?.symbolsListData?.symbolsAndValueDictionary
        if searchText.isEmpty {
            filteredSymbols = symbolList
        } else {
            filteredSymbols = symbolList?.filter { key, value in
                key.localizedCaseInsensitiveContains(searchText) ||
                value.localizedCaseInsensitiveContains(searchText)
            }
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSymbols(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchSymbols(for: "")
    }
}
