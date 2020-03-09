//
//  AccountTransactionTests.swift
//  MyDailyEconomyAppTests
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import MyDailyEconomyApp


class AccountTransactionTests: XCTestCase {

    let fiveEuros = Value.init(amount: 5, currency: .EUR)
    let tenDollars = Value.init(amount: 10, currency: .USD)
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation(){
        XCTAssertNotNil(AccountTransaction.salaryTransaction(value: fiveEuros))
        XCTAssertNotNil(AccountTransaction.carTransaction(value: tenDollars))

    }
    
    func testEquality(){
        //For classes we can have identical objets or equivalents
        let salary1 = AccountTransaction.salaryTransaction(value: fiveEuros)
        let salary2 = AccountTransaction.salaryTransaction(value: fiveEuros)
        let salary3 = AccountTransaction.salaryTransaction(value: tenDollars)
        
        XCTAssertEqual(salary1, salary2)
        XCTAssertNotEqual(salary2, salary3)
    }

}
