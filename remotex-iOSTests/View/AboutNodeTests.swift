//
//  AboutNodeTests.swift
//  remotex-iOS
//
//  Created by archimboldi on 31/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import FBSnapshotTestCase
import AsyncDisplayKit

class AboutNodeTests: FBSnapshotTestCase {
        
    override func setUp() {
        super.setUp()
        
        recordMode = false
    }
    
    func testInit() {
        let aboutNode = AboutNode.init(aboutModel: AboutModel.init())
        XCTAssertNotNil(aboutNode)
        XCTAssertEqual(aboutNode.view.frame, CGRect.init(x: 0, y: 0, width: 0, height: 0))
        XCTAssertNotNil(aboutNode.subnodes)
        XCTAssert(aboutNode.subnodes[0].isKind(of: ASScrollNode.self))
        
        let scrollNode = aboutNode.subnodes[0]
        XCTAssertEqual(scrollNode.subnodes.count, 6)
        let titleNode = scrollNode.subnodes[0] as! ASTextNode
        let sloganNode = scrollNode.subnodes[1] as! ASTextNode
        let descriptionNode = scrollNode.subnodes[2] as! ASTextNode
        let authorNode = scrollNode.subnodes[3] as! ASTextNode
        let linkInfoNode = scrollNode.subnodes[4] as! ASTextNode
        let versionNode = scrollNode.subnodes[5] as! ASTextNode
        
        XCTAssertNotNil(titleNode)
        XCTAssertEqual(titleNode.view.frame, CGRect.init(x: 0, y: 0, width: 0, height: 0))
        let titleAttr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Constants.AboutLayout.TitleFontSize)
        ]
        XCTAssertEqual(titleNode.attributedText, NSAttributedString.init(string: "RemoteX", attributes: titleAttr))
        
        XCTAssertNotNil(sloganNode)
        XCTAssertEqual(sloganNode.view.frame, CGRect.init(x: 0, y: 0, width: 0, height: 0))
        let sloganAttr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Constants.AboutLayout.SloganFontSize)
        ]
        XCTAssertEqual(sloganNode.attributedText, NSAttributedString.init(string: "快乐工作  认真生活", attributes: sloganAttr))
        
        XCTAssertNotNil(descriptionNode)
        XCTAssertEqual(sloganNode.view.frame, CGRect.init(x: 0, y: 0, width: 0, height: 0))
        XCTAssertEqual(descriptionNode.attributedText?.string, "RemoteX 是一个关于远程、兼职、外包、众包等信息的聚合平台，我们将需求从不同的平台汇集到这里，非盈利组织运作。\n欢迎需求方、开发方联系我们。")
        
        XCTAssertNotNil(authorNode)
        XCTAssertEqual(authorNode.view.frame, CGRect.init(x: 0, y: 0, width: 0, height: 0))
        let authorText = "RemoteX iOS App 由 @ArchimboldiMao 创建，并带领 RemoteX iOS 社区共同开发，详细贡献者信息请点击查看贡献者列表。\n欢迎前往社区 GitHub 主页围观源代码。"
        XCTAssertEqual(authorNode.attributedText?.string, authorText)
        
        XCTAssertNotNil(linkInfoNode)
        XCTAssertEqual(linkInfoNode.view.frame, CGRect.init(x: 0, y: 0, width: 0, height: 0))
        let linkInfoText = "联系方式\n网 站：https://remotex.ooclab.org\nSlack：https://remotex.slack.com\n邮 件：admin@ooclab.org\nqq群: remotex 633498747\n微信群: 加 lijian_gnu 拉入群"
        XCTAssertEqual(linkInfoNode.attributedText?.string, linkInfoText)
        
        XCTAssertNotNil(versionNode)
        XCTAssertEqual(versionNode.view.frame, CGRect.init(x: 0, y: 0, width: 0, height: 0))
        let versionText = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as! String
        let buildText = Bundle.main.infoDictionary?["CFBundleVersion"]  as! String
        let version = "Version \(versionText) (Build \(buildText))"
        XCTAssertEqual(versionNode.attributedText?.string, version)
        
        
        let screenSize = UIScreen.main.bounds.size
        aboutNode.frame = CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        // testInit@2x.png is a snapshot on iPhone 7 with iOS 10.3.
        TextureSnapshotVerifyNode(node: aboutNode)
        
    }
    
}

