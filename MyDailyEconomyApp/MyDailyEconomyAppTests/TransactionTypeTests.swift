//
//  TransactionTypeTests.swift
//  MyDailyEconomyAppTests
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import MyDailyEconomyApp

class TransactionTypeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testCreation(){
        for each in TransactionType.allCases {
            XCTAssertNotNil(each)
        }
    }
    
    func testEquality(){
        XCTAssertEqual(TransactionType.income, TransactionType.income)
        XCTAssertNotEqual(TransactionType.expense, TransactionType.income)
    }
    
    func testHashable(){
        XCTAssertEqual(TransactionType.income.hashValue, TransactionType.income.hashValue)
        XCTAssertNotEqual(TransactionType.expense.hashValue, TransactionType.income.hashValue)
        
    }

}
