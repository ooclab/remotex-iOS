//
//  Constants.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit

struct Constants {
    
    struct AppLayout {
        static let LogoForegroundColor: UIColor = UIColor.init(red: 0.31, green: 0.74, blue: 1.0, alpha: 1.0)
    }
    
    struct NavigationBarLayout {
        static let StatusBarBackgroundColor: UIColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.95)
    }
    
    struct TableLayout {
        static let BackgroundColor: UIColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
    }
    
    struct CellLayout {
        static let TitleFontSize: CGFloat = 18.0
        static let TitleForegroundColor: UIColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        static let PriceFontSize: CGFloat = 16.0
        static let TagFontSize: CGFloat = 14.0
        static let TagForegroundColor: UIColor = UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        static let TagBackgroundColor: UIColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        
        static let AbstractFontSize: CGFloat = 16.0
        static let AbstractForegroundColor: UIColor = TitleForegroundColor
        
        static let DateFontSize: CGFloat = 14.0
        static let DateForegroundColor: UIColor = UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        
        static let PriceForegroundColor: UIColor = UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
    }
    
    struct AboutLayout {
        static let TitleFontSize: CGFloat = 25.0
        static let SloganFontSize: CGFloat = 19.0
        static let DescriptionFontSize: CGFloat = 16.0
        static let VersionFontSize: CGFloat = 12.0
    }
    
    struct ShareContext {
        static let TitleText = "RemoteX 远程工作空间 -- 快乐工作 认真生活"
        static let AppStoreLinkURL = NSURL.init(string: "https://itunes.apple.com/app/id1236035785")!
        static let LogoImage = UIImage(named: "logo")!
    }
    
    struct AppStore {
        static let TitleText = "App Store"
        static let ReviewURL = URL(string: "itms-apps://itunes.apple.com/app/id1236035785?action=write-review")!
    }
    
    struct MessageDescription {
        static let NoInternetConnection = "网络连接超时。"
    }

}
