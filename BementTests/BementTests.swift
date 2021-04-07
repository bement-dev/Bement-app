//
//  BementTests.swift
//  BementTests
//
//  Created by Runkai Zhang on 9/2/19.
//  Copyright © 2019 The Bement School. All rights reserved.
//

import XCTest
@testable import Bement

class WeatherStoreTests: XCTestCase {

    var sunny:WeatherStore!
    
    override func setUp() {
        sunny = WeatherStore(uvIndex: 4, temperature: 72, summary: "Is sunny lol", icon: "sun.max.fill")
    }

    override func tearDown() {
        sunny = nil
    }

    func testTemperatureCanBeRetrieved() {
        XCTAssertEqual(sunny.temperature, 72)
    }

}
