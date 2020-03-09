//
//  TransactionTableViewCell.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 08/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var transactionTag: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var transactionDescrip: UITextView!
    @IBOutlet weak var transactionValue: UILabel!
    
    func setTransaction(transaction: AccountTransaction) {

        transactionDate.text = transaction.date
        transactionDescrip.text = transaction.description
        
        var currencyValue = ""
        switch transaction.value.currency {
        case .EUR:
            currencyValue = "€"
        case .USD:
            currencyValue = "$"
        case .BTC:
            currencyValue = "₿"
        }
        
        if transaction.transactionType == .income {
            transactionValue.text = "+\(transaction.value.amount) \(currencyValue)"
            transactionValue.textColor = UIColor.green
        } else {
            transactionValue.text = "\(transaction.value.amount) \(currencyValue)"
            transactionValue.textColor = UIColor.red
        }
        
        switch transaction.tag {
        case .salary:
            transactionTag.text = "SALARY"
            //self.backgroundColor = UIColor.init(named: transaction.colorTransaction)
        case .betEarnings:
            transactionTag.text = "BET EARNINGS"
            //self.backgroundColor = UIColor.init(named: transaction.colorTransaction)
        case .clothesSales:
            transactionTag.text = "CLOTHES SALES"
            //self.backgroundColor = UIColor.init(named: transaction.colorTransaction)
        case .renting:
            transactionTag.text = "FLAT RENTING"
            //self.backgroundColor = UIColor.init(named: transaction.colorTransaction)
        case .car:
            transactionTag.text = "CAR MAINTENANCE"
            //self.backgroundColor = UIColor.init(named: transaction.colorTransaction)
        case .food:
            transactionTag.text = "FOOD"
            //self.backgroundColor = UIColor.init(named: transaction.colorTransaction)
        case .party:
            transactionTag.text = "PARTY EXPENSES"
            //self.backgroundColor = UIColor.init(named: transaction.colorTransaction)
        }
    }
    
}
