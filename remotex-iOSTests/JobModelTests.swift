//
//  JobModelTests.swift
//  remotex-iOS
//
//  Created by archimboldi on 15/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import XCTest
@testable import remotex_iOS

class JobModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        let nilDictionary = [String: Any]()
        let nilModel = JobModel.init(dictionary: nilDictionary)
        XCTAssertNil(nilModel)
        
        let jobOnlyNecessaryString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"price\": 5000,\"abstract\": \"一、项目描述： 学生管理系统的微信端开发，主要针对学生的跟进，约见、到访、签约，针对学生之间的沟通记录管理。 公司提供UI与后端服务，只需要前端开发人员配合完成开发。 二、主要功能点： 消息对话、约见日程、到访反馈、签约退款、编辑学生资料、添加off\",\"view_count\": 2,\"vote_up\": 0,\"vote_down\": 0,\"created\": \"2017-05-15T03:01:49.636894Z\"}"
        if let onlyNecessaryData = jobOnlyNecessaryString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: onlyNecessaryData, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertNotNil(jobModel)
                XCTAssertEqual(jobModel?.jobID, 965)
                XCTAssertEqual(jobModel?.jobTitle, "学生多微信端开发")
                XCTAssertEqual(jobModel?.price, 5000)
                XCTAssertEqual(jobModel?.abstractText, "一、项目描述： 学生管理系统的微信端开发，主要针对学生的跟进，约见、到访、签约，针对学生之间的沟通记录管理。 公司提供UI与后端服务，只需要前端开发人员配合完成开发。 二、主要功能点： 消息对话、约见日程、到访反馈、签约退款、编辑学生资料、添加off")
                XCTAssertEqual(jobModel?.viewCount, 2)
                XCTAssertEqual(jobModel?.voteUp, 0)
                XCTAssertEqual(jobModel?.voteDown, 0)
                XCTAssertEqual(jobModel?.createdAt, Date.dateWithRFC3339String(from: "2017-05-15T03:01:49.636894Z"))
                XCTAssertNil(jobModel?.updatedAt)
                XCTAssertNil(jobModel?.releaseAt)
                XCTAssertNil(jobModel?.expireAt)
                XCTAssertEqual(jobModel?.cityName, "")
                XCTAssertNil(jobModel?.roles)
                XCTAssertNil(jobModel?.skills)
                XCTAssertNil(jobModel?.platform)
                XCTAssertNil(jobModel?.categories)
            } catch {
                XCTAssert(false, "Can't convert \(jobOnlyNecessaryString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobOnlyNecessaryString) to data using by utf8")
        }
        
        let jobString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"一、项目描述： 学生管理系统的微信端开发，主要针对学生的跟进，约见、到访、签约，针对学生之间的沟通记录管理。 公司提供UI与后端服务，只需要前端开发人员配合完成开发。 二、主要功能点： 消息对话、约见日程、到访反馈、签约退款、编辑学生资料、添加off\",\"price\": 5000, \"city\": null,\"view_count\": 2,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T09:48:33Z\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        
        if let data = jobString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertNotNil(jobModel)
                XCTAssertEqual(jobModel?.jobID, 965)
                XCTAssertEqual(jobModel?.jobTitle, "学生多微信端开发")
                XCTAssertEqual(jobModel?.price, 5000)
                XCTAssertEqual(jobModel?.abstractText, "一、项目描述： 学生管理系统的微信端开发，主要针对学生的跟进，约见、到访、签约，针对学生之间的沟通记录管理。 公司提供UI与后端服务，只需要前端开发人员配合完成开发。 二、主要功能点： 消息对话、约见日程、到访反馈、签约退款、编辑学生资料、添加off")
                XCTAssertEqual(jobModel?.viewCount, 2)
                XCTAssertEqual(jobModel?.voteUp, 0)
                XCTAssertEqual(jobModel?.voteDown, 0)
                XCTAssertEqual(jobModel?.cityName, "")
                XCTAssertEqual(jobModel?.createdAt, Date.dateWithRFC3339String(from: "2017-05-15T03:01:49.636894Z"))
                XCTAssertEqual(jobModel?.releaseAt, Date.dateWithRFC3339String(from: "2017-05-15T09:48:33Z"))
                XCTAssertEqual(jobModel?.updatedAt, Date.dateWithRFC3339String(from: "2017-05-15T03:17:33.678267Z"))
                XCTAssertEqual(jobModel?.expireAt, Date.dateWithRFC3339String(from: "2017-05-15T09:48:33Z"))
                XCTAssertNotNil(jobModel?.platform)
                XCTAssertEqual(jobModel?.platform?.platformID, 6)
                XCTAssertEqual(jobModel?.platform?.platformName, "大鲲网")
                XCTAssertEqual(jobModel?.platform?.homeURL, nil)
                XCTAssertEqual(jobModel?.platform?.summaryText, "")
                XCTAssertEqual(jobModel?.platform?.lastSyncedAt, Date.dateWithRFC3339String(from: "2017-05-15T03:17:33.678248Z"))
                XCTAssertNotNil(jobModel?.categories)
                XCTAssertEqual(jobModel?.categories?.count, 2)
            } catch {
                XCTAssert(false, "Can't convert \(jobString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobString) to data using by utf8")
        }
    }
    
    func testPriceOnScreen() {
        let jobPriceZeroString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 2,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T09:48:33Z\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataZero = jobPriceZeroString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataZero, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertEqual(jobModel?.price, 0)
                XCTAssertEqual(jobModel?.priceOnScreen, "未报价")
            } catch {
                XCTAssert(false, "Can't convert \(jobPriceZeroString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobPriceZeroString) to data using by utf8")
        }
        
        let jobPrice5000String = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 5000, \"city\": null,\"view_count\": 2,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T09:48:33Z\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let data5000 = jobPrice5000String.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data5000, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertEqual(jobModel?.price, 5000)
                XCTAssertEqual(jobModel?.priceOnScreen, "¥5,000")
            } catch {
                XCTAssert(false, "Can't convert \(jobPriceZeroString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobPriceZeroString) to data using by utf8")
        }
        
        let jobPrice5000000String = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 5000000, \"city\": null,\"view_count\": 2,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T09:48:33Z\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let data5000000 = jobPrice5000000String.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data5000000, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertEqual(jobModel?.price, 5000000)
                XCTAssertEqual(jobModel?.priceOnScreen, "¥5,000,000")
            } catch {
                XCTAssert(false, "Can't convert \(jobPriceZeroString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobPriceZeroString) to data using by utf8")
        }
    }
    
    func testViewCountOnScreen() {
        let jobViewCountZeroString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T09:48:33Z\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataZero = jobViewCountZeroString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataZero, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertEqual(jobModel?.viewCount, 0)
                XCTAssertEqual(jobModel?.viewCountOnScreen, "浏览0次")
            } catch {
                XCTAssert(false, "Can't convert \(jobViewCountZeroString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobViewCountZeroString) to data using by utf8")
        }
        
        let jobViewCount33String = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 33,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T09:48:33Z\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let data33 = jobViewCount33String.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data33, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertEqual(jobModel?.viewCount, 33)
                XCTAssertEqual(jobModel?.viewCountOnScreen, "浏览33次")
            } catch {
                XCTAssert(false, "Can't convert \(jobViewCount33String) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobViewCount33String) to data using by utf8")
        }
    }
    
    func testReleaseAtOnScreen() {
        let jobReleaseAtNilString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataNil = jobReleaseAtNilString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataNil, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertNil(jobModel?.releaseAt)
                XCTAssertEqual(jobModel?.releaseAtOnScreen, "")
            } catch {
                XCTAssert(false, "Can't convert \(jobReleaseAtNilString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobReleaseAtNilString) to data using by utf8")
        }
        
        let justDate = Date.init(timeIntervalSinceNow: -2*60)
        let justDateString = Date.RFC3339StringWithDate(from: justDate)
        let jobReleaseAtJustString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"\(justDateString)\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataJust = jobReleaseAtJustString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataJust, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertNotNil(jobModel?.releaseAt)
                XCTAssertEqual(jobModel?.releaseAtOnScreen, "刚刚发布")
            } catch {
                XCTAssert(false, "Can't convert \(jobReleaseAtJustString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobReleaseAtJustString) to data using by utf8")
        }
        
        let hours3BeforeDate = Date.init(timeIntervalSinceNow: -3*60*60)
        let hours3BeforeDateString = Date.RFC3339StringWithDate(from: hours3BeforeDate)
        let jobReleaseAtHours3BeforeString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"\(hours3BeforeDateString)\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataHours3Before = jobReleaseAtHours3BeforeString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataHours3Before, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)!
                XCTAssertNotNil(jobModel.releaseAt)
                XCTAssertEqual(Date.RFC3339StringWithDate(from: jobModel.releaseAt!), hours3BeforeDateString)
                XCTAssertEqual(jobModel.releaseAtOnScreen, "3小时前发布")
            } catch {
                XCTAssert(false, "Can't convert \(jobReleaseAtHours3BeforeString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobReleaseAtHours3BeforeString) to data using by utf8")
        }
        
        let days3BeforeDate = Date.init(timeIntervalSinceNow: -3*60*60*24)
        let days3BeforeDateString = Date.RFC3339StringWithDate(from: days3BeforeDate)
        let jobReleaseAtDays3BeforeString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"\(days3BeforeDateString)\",\"expire_date\": \"2017-05-15T09:48:33Z\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataDays3Before = jobReleaseAtDays3BeforeString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataDays3Before, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)!
                 XCTAssertNotNil(jobModel.releaseAt)
                XCTAssertEqual(Date.RFC3339StringWithDate(from: jobModel.releaseAt!), days3BeforeDateString)
                XCTAssertEqual(jobModel.releaseAtOnScreen, "3天前发布")
            } catch {
                XCTAssert(false, "Can't convert \(jobReleaseAtDays3BeforeString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobReleaseAtDays3BeforeString) to data using by utf8")
        }
    }
    // expireAtOnScreen
    
    func testExpireAtOnScreen() {
        let now = Date.init()
        let jobExpireAtNilString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataNil = jobExpireAtNilString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataNil, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)
                XCTAssertNil(jobModel?.expireAt)
                XCTAssertEqual(jobModel?.expireAtOnScreen, "")
            } catch {
                XCTAssert(false, "Can't convert \(jobExpireAtNilString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobExpireAtNilString) to data using by utf8")
        }
        
        let comingDate = Date.init(timeIntervalSinceNow: 2*60*60)
        let comingDateString = Date.RFC3339StringWithDate(from: comingDate)
        let jobExpireAtJustString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T03:01:49.636894Z\",\"expire_date\": \"\(comingDateString)\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataComing = jobExpireAtJustString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataComing, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)!
                XCTAssertNotNil(jobModel.expireAt)
                XCTAssertGreaterThan(jobModel.expireAt!, now)
                XCTAssertEqual(jobModel.expireAtOnScreen, "即将到期")
            } catch {
                XCTAssert(false, "Can't convert \(jobExpireAtJustString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobExpireAtJustString) to data using by utf8")
        }

        let days3AfterDate = Date.init(timeIntervalSinceNow: 4*60*60*24)
        let days3AfterDateString = Date.RFC3339StringWithDate(from: days3AfterDate)
        let jobExpireAtDays3AfterString = "{\"id\": 965,\"title\": \"学生多微信端开发\",\"abstract\": \"\",\"price\": 0, \"city\": null,\"view_count\": 0,\"vote_up\": 0,\"vote_down\": 0,\"release_date\": \"2017-05-15T03:01:49.636894Z\",\"expire_date\": \"\(days3AfterDateString)\",\"created\": \"2017-05-15T03:01:49.636894Z\",\"updated\": \"2017-05-15T03:17:33.678267Z\", \"platform\":{\"id\": 6,\"name\":\"大鲲网\",\"home_url\": \"\",\"summary\": \"\",\"last_sync\": \"2017-05-15T03:17:33.678248Z\"},\"categories\": [{\"id\": 23,\"name\": \"前端开发\",\"summary\": \"\"},{\"id\": 9,\"name\": \"HTML5\",\"summary\": \"\"}]}"
        if let dataDays3After = jobExpireAtDays3AfterString.data(using: .utf8) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataDays3After, options: []) as? JSONDictionary
                let jobModel = JobModel.init(dictionary: jsonData!)!
                XCTAssertNotNil(jobModel.expireAt)
                XCTAssertEqual(Date.RFC3339StringWithDate(from: jobModel.expireAt!), days3AfterDateString)
                XCTAssertGreaterThan(jobModel.expireAt!, now)
                XCTAssertEqual(jobModel.expireAtOnScreen, "将于3天后到期")
            } catch {
                XCTAssert(false, "Can't convert \(jobExpireAtDays3AfterString) to JSONDictionary")
            }
        } else {
            XCTAssert(false, "Can't convert \(jobExpireAtDays3AfterString) to data using by utf8")
        }
    }
}
