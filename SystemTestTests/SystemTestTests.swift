//
//  SystemTestTests.swift
//  SystemTestTests
//
//  Created by Raidu on 7/3/20.
//  Copyright © 2020 Raidu. All rights reserved.
//

import XCTest
@testable import SystemTest

class SystemTestTests: XCTestCase {
    var urlSession: URLSession!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlSession = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        urlSession = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testValidCallToGetsHTTPStatusCode200() {
        let url = URL(string: URLConstants.rowsURL)
        let promise = expectation(description: "Status code: 200")
        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                promise.fulfill()
                    
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testCheckForRowsCountNotZeroAndCheckTitle() {
        let promise = expectation(description: "Rows count not equal to zero")
        Network.getApiCallWithRequestURLString(requestString: URLConstants.rowsURL, completionBlock: { (data) in
            do {
                let str = String(decoding: data, as: UTF8.self)
                if let data = str.data(using: .utf8) {
                    let jsonDecoder = JSONDecoder()
                    /// Converting response to our custom model
                    let responseModel = try jsonDecoder.decode(MainJson.self, from: data)
                    XCTAssertNotNil(responseModel)
                    XCTAssertTrue(responseModel.title == "About Canada")
                    XCTAssertTrue(responseModel.rows?.count != 0)
                    promise.fulfill()
                }
            }
            catch(let error) {
                XCTFail("Status code: \(error.localizedDescription)")
            }
        }) { (error) in
            XCTFail("Status code: \(error.localizedDescription)")
        }
        wait(for: [promise], timeout: 5)
    }
}
