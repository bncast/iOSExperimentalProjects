//
//  SortingStrategyTests.swift
//  SortingStrategyTests
//
//  Created by Nino on 3/27/22.
//

import XCTest
@testable import SortingStrategy

class SortingStrategyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBubbleSort() throws {
        
        let strategy = BubbleSortStrategy()
        
        testUsingStrategy(strategy: strategy)
        
    }
    
    func testQuickSort() throws {
        
        let strategy = QuickSortStrategy()
        
        testUsingStrategy(strategy: strategy)
        
    }
    
    func testUsingStrategy(strategy: SortStrategy) {
        
        var input = "bcda"
        var output = strategy.sort(input)
        XCTAssertEqual(output, "abcd")
        
        input = ""
        output = strategy.sort(input)
        XCTAssertEqual(output, "")
        
        input = "abc123"
        output = strategy.sort(input)
        XCTAssertEqual(output, "123abc")
        
        input = "abc 123"
        output = strategy.sort(input)
        XCTAssertEqual(output, " 123abc")
        
        input = "VXeZdc"
        output = strategy.sort(input)
        XCTAssertEqual(output, "VXZcde")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
