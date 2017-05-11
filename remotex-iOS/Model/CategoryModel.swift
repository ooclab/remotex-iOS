//
//  CategoryModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit

struct CategoryModel {

    let categoryID: Int
    let categoryName: String
    let summaryText: String
    
    init?(dictionary: JSONDictionary) {
        guard let categoryID = dictionary["id"] as? Int, let categoryName = dictionary["name"] as? String, let summaryText = dictionary["summary"] as? String else {
            print("error parsing JSON within CategoryModel Init")
            return nil
        }
        self.categoryID = categoryID
        self.categoryName = categoryName
        self.summaryText = summaryText
    }
}

extension CategoryModel {
    func attrStringForCategoryName(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TagForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: categoryName, attributes: attr)
    }
    
    func attrStringForSummaryText(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TitleForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: summaryText, attributes: attr)
    }
}
