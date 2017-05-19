//
//  JobFeedTableNodeControllerTests.swift
//  remotex-iOS
//
//  Created by archimboldi on 18/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import XCTest
@testable import remotex_iOS

class JobFeedTableNodeControllerTests: XCTestCase {
    
    var nodeController: JobFeedTableNodeController!
    
    override func setUp() {
        super.setUp()
        
        nodeController = JobFeedTableNodeController()
        let navigationController = UINavigationController.init(rootViewController:  nodeController)
        
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        nodeController.viewDidAppear(false)
        
        // https://www.natashatherobot.com/ios-testing-view-controllers-swift/
        // must to run nodeController.view in setUp()
        XCTAssertNotNil(nodeController.view)
        XCTAssertNotNil(nodeController.node)
        XCTAssertNotNil(navigationController.view)
        XCTAssertEqual(NSStringFromCGRect(nodeController.view.frame), NSStringFromCGRect(navigationController.view.frame))
        XCTAssertEqual(NSStringFromCGRect(window.frame), NSStringFromCGRect(navigationController.view.frame))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testActivityIndicator() {
        nodeController.setupActivityIndicator()
        XCTAssertNotNil(nodeController.activityIndicator)
    }
    
    func testJobFeedEmpty() {
        let jobFeed = nodeController.jobFeed
        XCTAssertNotNil(jobFeed)
        XCTAssertNotNil(jobFeed.jobs)
        XCTAssertEqual(jobFeed.jobs.count, jobFeed.numberOfItemsInFeed)
    }
    
    func testNavigation() {
        nodeController.setupNavigation()
        XCTAssertEqual(nodeController.navigationItem.title, "RemoteX")
        XCTAssertNotNil(nodeController.navigationController)
        XCTAssert((nodeController.navigationController?.hidesBarsOnSwipe)!)
    }
    
    func testRefreshControl() {
        nodeController.setupRefreshControl()
        XCTAssertNotNil(nodeController.refreshControl)
    }
    
    func testStatusBar() {
        nodeController.setupStatusBar()
        XCTAssertNotNil(nodeController.statusBarNode)
        XCTAssertEqual(nodeController.statusBarNode.isHidden, UIDevice.current.orientation.isLandscape)
    }
}
