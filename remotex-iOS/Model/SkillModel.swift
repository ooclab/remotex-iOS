//
//  SkillModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit

struct SkillModel {
    let skillID: Int
    let skillName: String
    
    init?(dictionary: JSONDictionary) {
        guard let skillID = dictionary["id"] as? Int, let skillName = dictionary["name"] as? String else {
            print("error parsing JSON within SkillModel Init")
            return nil
        }
        self.skillID = skillID
        self.skillName = skillName
    }
}

extension SkillModel {
    func attrStringForSkillName(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TagForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: skillName, attributes: attr)
    }
}
