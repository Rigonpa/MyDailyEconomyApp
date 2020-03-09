//
//  TagTests.swift
//  MyDailyEconomyAppTests
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import MyDailyEconomyApp

class TagTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation() {
        for each in Tag.allCases {
            XCTAssertNotNil(each)
        }
    }
    
    func testEquality(){
        XCTAssertNotEqual(Tag.car, Tag.betEarnings)
        XCTAssertEqual(Tag.clothesSales, Tag.clothesSales)
    }

    func testHashable(){
        XCTAssertNotEqual(Tag.car.hashValue, Tag.betEarnings.hashValue)  // Is not strictly necessary but is free
        XCTAssertEqual(Tag.clothesSales.hashValue, Tag.clothesSales.hashValue)
    }
}
