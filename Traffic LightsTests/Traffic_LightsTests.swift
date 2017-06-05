//
//  Traffic_LightsTests.swift
//  Traffic LightsTests
//

import XCTest
@testable import Traffic_Lights

class Traffic_LightsTests: XCTestCase {
  
    var vc = ViewController()
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      vc = storyboard.instantiateInitialViewController() as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTrafficLightAngle() {
      let _ = vc.view
    }
  
    func testChangeTrafficLightDirection() {
    }
    
    func testUpdateLight() {
      let _ = vc.view
    }
  
    func testSwitchButtonPressed() {
      let _ = vc.view
    }
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
