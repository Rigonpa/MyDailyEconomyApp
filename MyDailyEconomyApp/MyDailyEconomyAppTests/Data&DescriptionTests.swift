//
//  Data&DescriptionTests.swift
//  MyDailyEconomyAppTests
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import MyDailyEconomyApp

class Data_DescriptionTests: XCTestCase {

    let date1: TransactionDate = "21-12-2017"
    let date2: TransactionDate = "08-04-2019"
    
    let desc1: TransactionDescrip = "Having lunch with friends at Nine's"
    let desc2: TransactionDescrip = "Salary of JAN-2020"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreation() {
        XCTAssertNotNil(date1)
        XCTAssertNotNil(date2)
        XCTAssertNotNil(desc1)
        XCTAssertNotNil(desc2)
    }
    
}
