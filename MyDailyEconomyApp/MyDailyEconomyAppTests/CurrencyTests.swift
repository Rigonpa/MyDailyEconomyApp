//
//  CurrencyTests.swift
//  MyDailyEconomyAppTests
//
//  Created by Ricardo González Pacheco on 05/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import MyDailyEconomyApp

class CurrencyTests: XCTestCase {
    
    let euro = Currency.EUR
    let usd = Currency.USD

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation(){
        XCTAssertNotNil(euro)
        XCTAssertNotNil(usd)
    }
    
//    func testCodeConsistency(){
//       Not necessary
//    }
    
    func testEquality(){
        XCTAssertNotEqual(euro, usd)
        XCTAssertEqual(euro, Currency.EUR)
    }
}
