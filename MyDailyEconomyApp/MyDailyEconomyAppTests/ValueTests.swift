//
//  ValueTests.swift
//  MyDailyEconomyAppTests
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import MyDailyEconomyApp

class ValueTests: XCTestCase {

    var fiveEuros = Value.init(amount: 5.0, currency: .EUR)
    var sevenDollars = Value.init(amount: 7.0, currency: .USD)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation(){
        XCTAssertNotNil(fiveEuros)
        XCTAssertNotNil(sevenDollars)
    }

    func testEquality() {
        XCTAssertNotEqual(fiveEuros, sevenDollars)
        XCTAssertEqual(fiveEuros, Value.init(amount: 5.0, currency: .EUR))
        
        // Torture Test - QuickCheck does this automatically
        XCTAssertEqual(Value.init(amount: 5.0, currency: .EUR), Value.init(amount: 5, currency: .EUR))
        XCTAssertNotEqual(Value.init(amount: 5.9, currency: .EUR), Value.init(amount: 5, currency: .EUR))
        XCTAssertNotEqual(Value.init(amount: 5.0, currency: .BTC), Value.init(amount: 5, currency: .EUR))
    }
    
    func testHashable() {
        XCTAssertNotEqual(fiveEuros.hashValue, sevenDollars.hashValue)
        XCTAssertEqual(fiveEuros.hashValue, Value.init(amount: 5.0, currency: .EUR).hashValue)
        
        
        XCTAssertEqual(Value.init(amount: 5.0, currency: .EUR).hashValue, Value.init(amount: 5, currency: .EUR).hashValue)
        XCTAssertNotEqual(Value.init(amount: 5.9, currency: .EUR).hashValue, Value.init(amount: 5, currency: .EUR).hashValue)
        XCTAssertNotEqual(Value.init(amount: 5.0, currency: .BTC).hashValue, Value.init(amount: 5, currency: .EUR).hashValue)
    }


}
