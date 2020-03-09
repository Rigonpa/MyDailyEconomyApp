//
//  Amount.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 05/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

struct Value: Hashable {
    var amount: Double
    var currency: Currency
        
    init(amount: Double, currency: Currency) {
        (self.amount, self.currency) = (amount, currency)
    }
    
//    init(amount: Double, currency code: ISO4217) {
//        (self.amount, self.code) = (amount, Currency.init(code: code) )
//    }    
}
    
extension Value: Equatable {
    static func == (lhs: Value, rhs: Value) -> Bool {
        return
            lhs.amount == rhs.amount &&
            lhs.currency == rhs.currency
    }
}


