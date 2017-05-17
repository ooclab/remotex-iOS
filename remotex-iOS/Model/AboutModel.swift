//
//  AboutModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 14/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit

struct AboutModel {
    let aboutTitle: String
    let slogan: String
    let description: String
    let author: String
    let authorTwitterUsername: String
    let remoteXiOSGitHub: String
    let remoteXWebSite: String
    let remoteXSlack: String
    let remoteXEmail: String
    let linkInfo: String
    
    
    init() {
        self.aboutTitle = "RemoteX"
        self.slogan = "快乐工作  认真生活"
        self.description = "RemoteX 远程工作空间是一个远程／众包／外包的信息聚合平台，我们将需求从不同的平台汇集到这里，非盈利组织运作。\n欢迎需求方／开发方联系我们。"
        self.authorTwitterUsername = "@ArchimboldiMao"
        self.remoteXiOSGitHub = "GitHub(remotex-iOS)"
        self.author = "RemoteX iOS App 由 \(authorTwitterUsername) 开发，欢迎前往 \(remoteXiOSGitHub) 主页点赞收藏。"
        
        self.remoteXWebSite = "https://remotex.ooclab.org"
        self.remoteXSlack = "https://remotex.slack.com"
        self.remoteXEmail = "admin@ooclab.org"
        self.linkInfo = "联系方式\n网 站：\(remoteXWebSite)\nSlack：\(remoteXSlack)\n邮 件：\(remoteXEmail)\nqq群: remotex 633498747\n微信群: 加 lijian_gnu 拉入群"
        
    }
}

