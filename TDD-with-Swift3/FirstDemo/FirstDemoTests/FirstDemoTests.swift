//
//  FirstDemoTests.swift
//  FirstDemoTests
//
//  Created by Liem Vo on 5/7/17.
//  Copyright © 2017 Cyberbot. All rights reserved.
//

import XCTest
@testable import FirstDemo

class FirstDemoTests: XCTestCase {
    var viewController: ViewController!
    override func setUp() {
        super.setUp()
        viewController = ViewController()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func test_NumberOfVowels_WhenPassedDominik_ReturnThree() {
        let input = "Dominik"
        let expectedOutput = 3
        
        let numberOfVowels = viewController.numberOfVowels(in: input)
        XCTAssertEqual(numberOfVowels, expectedOutput, "Should find \(expectedOutput) vowels in \(input)")
    }
    
    func test_MakeHeadline_ReturnStringWithEachWorldStartCapital() {
        let input = "this is A test headline"
        let expectedOutput = "This Is A Test Headline"
        let headline = viewController.makeHeadline(from: input)
        
        XCTAssertEqual(headline, expectedOutput)
    }
    
    func test_MakeHeadline_ReturnStringWithEachWorldStartCapital2() {
        let input = "Here is another example"
        let expectedOutput = "Here Is Another Example"
        let headline = viewController.makeHeadline(from: input)
        
        XCTAssertEqual(headline, expectedOutput)
    }
}
