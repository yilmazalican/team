//
//  iFlatTests.swift
//  iFlatTests
//
//  Created by Alican Yilmaz on 24/11/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import XCTest
import Firebase
@testable import iFlat

class UsermodelTests: XCTestCase {
   
    let endpoint = FIRUSER()
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        var expect = expectation(description: "wait this test")
        endpoint.loginByEmailAndPassword(email: "eposta.alican@gmail.com", password: "123456") { (str) in
            if str == nil{
                print(str.debugDescription)
                expect.fulfill()
            }
            else{
                print(str.debugDescription)
                expect.fulfill()
                XCTAssert(false)

            }
        }
        

        self.waitForExpectations(timeout: 10.0) { (err) in
            if (err != nil) {
                XCTFail("failed due to timeout")
            }
        }
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
