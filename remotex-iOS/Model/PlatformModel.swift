//
//  PlatformModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit

struct PlatformModel {
    let platformID: Int
    let platformName: String
    let summaryText: String
    let homeURL: URL?
    
    init?(dictionary: JSONDictionary) {
        guard let platformID = dictionary["id"] as? Int, let platformName = dictionary["name"] as? String, let homeURL = dictionary["home_url"] as? String, let summaryText = dictionary["summary"] as? String else {
            print("error parsing JSON within PlatformModel Init")
            return nil
        }
        self.platformID = platformID
        self.platformName = platformName
        self.summaryText = summaryText
        if homeURL.hasPrefix("http") {
            self.homeURL = URL(string: homeURL)!
        } else {
            self.homeURL = nil
        }
    }
}


extension PlatformModel {
    func attrStringForPlatformName(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TagForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: platformName, attributes: attr)
    }
    
    func attrStringForSummaryText(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TitleForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: summaryText, attributes: attr)
    }
}
