//
//  MainViewController.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 07/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

protocol TransactionAddedProtocol {
    func didTransactionAdded()
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TransactionAddedProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedValue: UISegmentedControl!
    @IBOutlet weak var totalAmount: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "TransactionTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TransactionTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.segmentedValue.selectedSegmentIndex = 1
        self.totalAmount.text = ""
    }
    
    func didTransactionAdded() {
        self.tableView.reloadData()
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        
        let newTransactionVC = NewTransactionViewController()
        newTransactionVC.delegate = self
        self.present(newTransactionVC, animated: true, completion: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .fullScreen
        
        newTransactionVC.updateTotal = {() -> Void in
            
            
            let sum = DataController.shared.total(resultIn: .EUR, index: self.segmentedValue.selectedSegmentIndex)
            
            var currencY = ""
            switch sum.currency {
            case .EUR:
                currencY = "€"
            case .USD:
                currencY = "$"
            default:
                currencY = "₿"
            }
            
            self.totalAmount.text = "\(sum.amount) \(currencY)"
            
            if sum.amount < 0 {
                self.totalAmount.isHidden = false
                self.totalAmount.textColor = UIColor.red
            } else if sum.amount >= 0 {
                self.totalAmount.isHidden = false
                self.totalAmount.textColor = UIColor.green
            }
            
            if DataController.shared.numberTransactions(segmentedValue: self.segmentedValue.selectedSegmentIndex) == 0 {
                self.totalAmount.isHidden = true
            } else {
                self.totalAmount.isHidden = false
            }
            
        }
        
        
        
        
    }
    
    @IBAction func changeButton(_ sender: Any) {
        self.tableView.reloadData()
        

        
        if DataController.shared.numberTransactions(segmentedValue: segmentedValue.selectedSegmentIndex) != 0 {

                let sum = DataController.shared.total(resultIn: .EUR, index: self.segmentedValue.selectedSegmentIndex)
                
                var cur = ""
                switch sum.currency {
                case .EUR:
                    cur = "€"
                case .USD:
                    cur = "$"
                default:
                    cur = "₿"
                }
                
                self.totalAmount.text = "\(sum.amount) \(cur)"
                
                if sum.amount < 0 {
                    self.totalAmount.isHidden = false
                    self.totalAmount.textColor = UIColor.red
                } else if sum.amount >= 0 {
                    self.totalAmount.isHidden = false
                    self.totalAmount.textColor = UIColor.green
                }
            }
    }

    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    
    // UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataController.shared.numberTransactions(segmentedValue: segmentedValue.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell {
            cell.setTransaction(transaction: DataController.shared.transacciones(index: indexPath.row, segmentedValue: segmentedValue.selectedSegmentIndex))
            return cell
        }
        fatalError("Impossible to create the transaction cell")
    }
    
}
