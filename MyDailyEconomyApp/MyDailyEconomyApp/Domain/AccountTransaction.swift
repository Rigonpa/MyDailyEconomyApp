//
//  AccountTransaction.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 05/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

// CLASS CLUSTER!!!!



class AccountTransaction {
    let value: Value
    let tag: Tag
    let transactionType: TransactionType
    //var colorTransaction: String = ""
    
    let date: TransactionDate
    let description: TransactionDescrip
    
    
    // Designated init
    fileprivate init(value: Value, tag: Tag, transactionType: TransactionType, date: TransactionDate, description: TransactionDescrip) {
        (self.value, self.tag, self.transactionType, self.date, self.description) = (value, tag, transactionType, date, description)
    }
    
    // Métodos factory que crean las subclases específicas
    static func salaryTransaction(value: Value, date: TransactionDate, description: TransactionDescrip) -> AccountTransaction{
        return SalaryTransaction(value: value, tag: .salary, transactionType: .income, date: date, description: description)
    }
    
    static func betEarningTransaction(value: Value, date: TransactionDate, description: TransactionDescrip) -> AccountTransaction{
        return BetEarningTransaction(value: value, tag: .betEarnings, transactionType: .income, date: date, description: description)
    }
    
    static func clothesSalesTransaction(value: Value, date: TransactionDate, description: TransactionDescrip) -> AccountTransaction{
        return ClothesSalesTransaction(value: value, tag: .clothesSales, transactionType: .income, date: date, description: description)
    }
    
    static func rentingTransaction(value: Value, date: TransactionDate, description: TransactionDescrip) -> AccountTransaction{
        return RentingTransaction(value: value, tag: .renting, transactionType: .expense, date: date, description: description)
    }
    
    static func foodTransaction(value: Value, date: TransactionDate, description: TransactionDescrip) -> AccountTransaction{
        return FoodTransaction(value: value, tag: .food, transactionType: .expense, date: date, description: description)
    }
    
    static func carTransaction(value: Value, date: TransactionDate, description: TransactionDescrip) -> AccountTransaction{
        return CarTransaction(value: value, tag: .car, transactionType: .expense, date: date, description: description)
    }
    
    static func partyTransaction(value: Value, date: TransactionDate, description: TransactionDescrip) -> AccountTransaction{
        return PartyTransaction(value: value, tag: .party, transactionType: .expense, date: date, description: description)
    }
    
}

//  Subclases con la particularidad de cada caso. Vamos a implementar que en función del tag el fondo de la celda sea de un color específico. Es un caso sencillo que seguramente se podría implementar con un if else en la clase AccountTransaction pero el objetivo es crear la estructura por si para cada tag hubiera que hacer cosas muy distintas, que en un proyecto real es lo que puede llegar a ocurrir y es el motivo por el que hay que aprender este sistema factory. - ERROR: SIN UTILIDAD!!!!

fileprivate class SalaryTransaction: AccountTransaction {
//    func setColorTransaction(){
//        colorTransaction = "green"
//    }
}

fileprivate class BetEarningTransaction: AccountTransaction {
    
//    func setColorTransaction(){
//        colorTransaction = "blue"
//    }
}

fileprivate class ClothesSalesTransaction: AccountTransaction {
//    func setColorTransaction(){
//        colorTransaction = "brown"
//    }
}

fileprivate class RentingTransaction: AccountTransaction {
//    func setColorTransaction(){
//        colorTransaction = "red"
//    }
}

fileprivate class FoodTransaction: AccountTransaction {
//    func setColorTransaction(){
//        colorTransaction = "magenta"
//    }
}

fileprivate class CarTransaction: AccountTransaction {
//    func setColorTransaction(){
//        colorTransaction = "orange"
//    }
}

fileprivate class PartyTransaction: AccountTransaction {
//    func setColorTransaction(){
//        colorTransaction = "yellow"
//    }
}

extension AccountTransaction: Equatable {
    static func == (lhs: AccountTransaction, rhs: AccountTransaction) -> Bool {
        return
            lhs.value == rhs.value &&
            lhs.tag == rhs.tag &&
            lhs.transactionType == rhs.transactionType &&
//            lhs.colorTransaction == rhs.colorTransaction &&
            lhs.date == rhs.date &&
            lhs.description == rhs.description
    }
    
}

extension AccountTransaction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(tag)
        hasher.combine(transactionType)
//        hasher.combine(colorTransaction)
        hasher.combine(date)
        hasher.combine(description)
    }
}
