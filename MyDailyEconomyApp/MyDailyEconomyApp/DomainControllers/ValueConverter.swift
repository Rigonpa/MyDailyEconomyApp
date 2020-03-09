//
//  ValueConverter.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol ValueConverter {
    func converter(value: Value, toCurrency: Currency) -> Value
}

struct DummyConverter: ValueConverter {

    // It is gonna be a singleton
    static let shared = DummyConverter()
    private init() {  }
    
    let rateBitEur = 7000.00 // 1 btc 7000 euros
    let rateDolEur = 0.89 // 1 dolar 0.89 euros
    
    func converter(value: Value, toCurrency: Currency) -> Value {
        
        if value.currency == toCurrency {
            return value
        } else if value.currency == .BTC && toCurrency == .EUR {
            return Value.init(amount: value.amount * rateBitEur, currency: toCurrency)
        } else if value.currency == .USD && toCurrency == .EUR {
            return Value.init(amount: value.amount * rateDolEur, currency: toCurrency)
        } else {
            return value
        }
    }
    
}
