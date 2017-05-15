//
//  JobModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]

struct JobModel {
    
    let jobID: Int
    let jobTitle: String
    let price: Double
    let abstractText: String
    let createdAt: Date
    let updatedAt: Date?
    let releaseAt: Date?
    let expireAt: Date?
    let viewCount: Int
    let voteUp: Int
    let voteDown: Int
    let cityName: String?
    let roles: [RoleModel]?
    let skills: [SkillModel]?
    let platform: PlatformModel?
    let categories: [CategoryModel]?
    
    init?(dictionary: JSONDictionary) {
        guard let jobID = dictionary["id"] as? Int, let jobTitle = dictionary["title"] as? String, let createdAtString = dictionary["created"] as? String, let price = dictionary["price"] as? Double, let viewCount = dictionary["view_count"] as? Int, let voteUp = dictionary["vote_up"] as? Int, let voteDown = dictionary["vote_down"] as? Int else {
            print("error parsing JSON within JobModel Init")
            return nil
        }
        
        self.jobID = jobID
        self.jobTitle = jobTitle
        self.price = price
        self.voteUp = voteUp
        self.voteDown = voteDown
        self.viewCount = viewCount
        
        if let platform = dictionary["platform"] as? JSONDictionary {
            self.platform = PlatformModel.init(dictionary: platform)!
        } else {
            self.platform = nil
        }
        
        self.createdAt = Date.dateWithRFC3339String(from: createdAtString)!
        if let updatedString = dictionary["updated"] as? String {
            self.updatedAt = Date.dateWithRFC3339String(from: updatedString) ?? nil
        } else {
            self.updatedAt = nil;
        }
        if let releaseDateString = dictionary["release_date"] as? String {
            self.releaseAt = Date.dateWithRFC3339String(from: releaseDateString) ?? nil
        } else {
            self.releaseAt = nil;
        }
        if let expireDateString = dictionary["expire_date"] as? String {
            self.expireAt = Date.dateWithRFC3339String(from: expireDateString) ?? nil
        } else {
            self.expireAt = nil;
        }
        
        self.cityName = dictionary["city"] as? String ?? ""
        
        self.abstractText = dictionary["abstract"] as? String ?? ""
        
        if let categories = dictionary["categories"] as? [JSONDictionary] {
            self.categories = categories.flatMap(CategoryModel.init)
        } else {
            self.categories = nil
        }
        
        if let roles = dictionary["roles"] as? [JSONDictionary] {
            self.roles = roles.flatMap(RoleModel.init)
        } else {
            self.roles = nil
        }
        
        if let skills = dictionary["skills"] as? [JSONDictionary] {
            self.skills = skills.flatMap(SkillModel.init)
        } else {
            self.skills = nil
        }
        
    }
}

extension JobModel {
    var priceOnScreen: String {
        if price <= 0 {
            return "未报价"
        } else {
            return NumberFormatter.formatRMBCurrency(value: price)
        }
    }
    
    var viewCountOnScreen: String {
        return "浏览\(viewCount)次"
    }
    
    var releaseAtOnScreen: String {
        if (releaseAt != nil) {
            let currentCalendar = NSCalendar.current
            let dayComponents = currentCalendar.dateComponents([.day], from: releaseAt!, to: Date())
            if dayComponents.day! >= 1 {
                return "\(dayComponents.day!)天前发布"
            } else {
                let hourComponents = currentCalendar.dateComponents([.hour], from: releaseAt!, to: Date())
                if hourComponents.hour! >= 1 {
                    return "\(hourComponents.hour!)小时前发布"
                } else {
                    return "刚刚发布"
                }
            }
        } else {
            return ""
        }
    }
    
    var expireAtOnScreen: String {
        if (expireAt != nil) {
            let currentCalendar = NSCalendar.current
            let dayComponents = currentCalendar.dateComponents([.day], from: expireAt!, to: Date())
            if dayComponents.day! >= 1 {
                return "将于\(dayComponents.day!)天后过期"
            } else {
                return "即将过期"
            }
        } else {
            return ""
        }
    }
    
    func attrStringForTitle(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TitleForegroundColor,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.jobTitle, attributes: attr)
    }
    
    func attrStringForPrice(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.PriceForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.priceOnScreen, attributes: attr)
    }
    
    func attrStringForAbstractText(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.AbstractForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.abstractText, attributes: attr)
    }
    
    func attrStringForViewCount(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.DateForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.viewCountOnScreen, attributes: attr)
    }
    
    func attrStringForReleaseAt(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.DateForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.releaseAtOnScreen, attributes: attr)
    }
    
    func attrStringForExpireAt(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.DateForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.expireAtOnScreen, attributes: attr)
    }
    
    func attrStringForCityName(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TagForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.cityName!, attributes: attr)
    }
    
}
