//
//  DataController.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 08/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class DataController{
    
    static var shared = DataController()
    private init(){  }
    
    private var transactionsList: [AccountTransaction] = []
    private var transactionsListIncome: [AccountTransaction] = []
    private var transactionsListExpense: [AccountTransaction] = []
    
    //    private var transactionsList: [AccountTransaction] = [
    //        AccountTransaction.salaryTransaction(value: Value.init(amount: 1212.34, currency: .EUR), date: "29/12/2019", description: "First salary of my lifeeeeeeee"),
    //        AccountTransaction.partyTransaction(value: Value.init(amount: -17.5, currency: .EUR), date: "24/02/2020", description: "pachá ticket"),
    //        AccountTransaction.rentingTransaction(value: Value.init(amount: -56.3, currency: .BTC), date: "15/01/2020", description: "I am paying in bitcoins to my hoster for next 3 months"),
    //        AccountTransaction.foodTransaction(value: Value.init(amount: -132.47, currency: .EUR), date: "05/02/2020", description: "Monthly food purchase + 10 chcocolate tablets"),
    //        AccountTransaction.betEarningTransaction(value: Value.init(amount: 22.4, currency: .EUR), date: "03/01/2020", description: "I bet Madrid wins Barsa so lucky me!"),
    //        AccountTransaction.carTransaction(value: Value.init(amount: -105, currency: .EUR), date: "22/02/2020", description: "2 Bridgestone wheels and forward axis alignment"),
    //        AccountTransaction.clothesSalesTransaction(value: Value.init(amount: 60, currency: .USD), date: "06/01/2020", description: "I have been paid in dollars because of selling my coat to a californian guy")
    //    ]
    //    private var transactionsList: [AccountTransaction] = [
    //        AccountTransaction.salaryTransaction(value: Value.init(amount: 10, currency: .EUR), date: "29/12/2019", description: "First salary of my lifeeeeeeee")
    //    ]
    //    private var transactionsListIncome: [AccountTransaction] = [
    //        AccountTransaction.salaryTransaction(value: Value.init(amount: 1212.34, currency: .EUR), date: "29/12/2019", description: "First salary of my lifeeeeeeee"),
    //        AccountTransaction.betEarningTransaction(value: Value.init(amount: 22.4, currency: .EUR), date: "03/01/2020", description: "I bet Madrid wins Barsa so lucky me!"),
    //        AccountTransaction.clothesSalesTransaction(value: Value.init(amount: 60, currency: .USD), date: "06/01/2020", description: "I have been paid in dollars because of selling my coat to a californian guy")
    //    ]
    //    private var transactionsListExpense: [AccountTransaction] = [
    //        AccountTransaction.partyTransaction(value: Value.init(amount: -17.5, currency: .EUR), date: "24/02/2020", description: "pachá ticket"),
    //        AccountTransaction.rentingTransaction(value: Value.init(amount: -56.3, currency: .BTC), date: "15/01/2020", description: "I am paying in bitcoins to my hoster for next 3 months"),
    //        AccountTransaction.foodTransaction(value: Value.init(amount: -132.47, currency: .EUR), date: "05/02/2020", description: "Monthly food purchase + 10 chcocolate tablets"),
    //        AccountTransaction.carTransaction(value: Value.init(amount: -105, currency: .EUR), date: "22/02/2020", description: "2 Bridgestone wheels and forward axis alignment")
    //    ]
    
    // MARK: - Managing transactions methods
    
    func insertTransaction(transaction: AccountTransaction){
        
        transactionsList.append(transaction)
        
        if transaction.transactionType == .expense {
            transactionsListExpense.append(transaction)
        } else {
            transactionsListIncome.append(transaction)
        }
    }
    
    func numberTransactions(segmentedValue value: Int) -> Int {
        
        switch value {
        case 0:
            return transactionsListIncome.count
        case 1:
            return transactionsList.count
        default:
            return transactionsListExpense.count
        }
    }
    
    func transacciones(index: Int, segmentedValue: Int) -> AccountTransaction {
        
        if segmentedValue == 0 {
            return transactionsListIncome[index]
        } else if segmentedValue == 1 {
            return transactionsList[index]
        } else {
            return transactionsListExpense[index]
        }
    }
    
    
    // MARK: - Applying conversion rate methods
    
    func total(resultIn code: Currency, index: Int) -> Value {
        let valuesConv = convertTransactionsList(toCurrency: code, index: index)
        let totalAmount = reduceTransaction(values: valuesConv)
        
        return Value.init(amount: totalAmount, currency: code)
    }
    
    func reduceTransaction(values: [Value]) -> Double {
        
        var total: Double = 0
        for each in values {
            total += each.amount
        }
        return total
    }
    
    func convertTransactionsList(toCurrency code: Currency, index: Int) -> [Value] {
        
        var transactionValuesConverted: [Value] = []
        
        if index == 0 {
            for eachTran in transactionsListIncome {
                let convertedValueOne = DummyConverter.shared.converter(value: eachTran.value, toCurrency: code)
                transactionValuesConverted.append(convertedValueOne)
            }
        } else if index == 1 {
            for eachTran in transactionsList {
                let convertedValueOne = DummyConverter.shared.converter(value: eachTran.value, toCurrency: code)
                transactionValuesConverted.append(convertedValueOne)
            }
        } else {
            for eachTran in transactionsListExpense {
                let convertedValueOne = DummyConverter.shared.converter(value: eachTran.value, toCurrency: code)
                transactionValuesConverted.append(convertedValueOne)
            }
        }
        
        return transactionValuesConverted
    }
    
    
    
    // MARK: - Managing UI Tests
    
    func initialAmountControl() -> (Int, Int) {
        return (transactionsListIncome.count, transactionsListExpense.count)
    }
    
    
    
    
    
    
}
