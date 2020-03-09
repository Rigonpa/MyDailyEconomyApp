//
//  ValueConverterTests.swift
//  MyDailyEconomyAppTests
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import MyDailyEconomyApp

class ValueConverterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // I have to test currency rates
    func testConvertToSameCurrency() {
        let dollar = Currency.USD
        let fiveDollar = Value.init(amount: 5, currency: dollar)
        
        XCTAssertEqual(fiveDollar, DummyConverter.shared.converter(value: fiveDollar, toCurrency: .USD))
    }
    
    func testConvertToDifferentCurrency() {
        let dollar = Currency.USD
        let euro = Currency.EUR
        
        let tenEuros = Value.init(amount: 10, currency: euro)
        let fiveDollars = Value.init(amount: 5, currency: dollar)
        
        XCTAssertEqual(fiveDollars, DummyConverter.shared.converter(value: tenEuros, toCurrency: dollar))
    }
}
