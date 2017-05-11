//
//  RoleModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit

struct RoleModel {
    let roleID: Int
    let roleName: String
    
    init?(dictionary: JSONDictionary) {
        guard let roleID = dictionary["id"] as? Int, let roleName = dictionary["name"] as? String else {
            print("error parsing JSON within RoleModel Init")
            return nil
        }
        self.roleID = roleID
        self.roleName = roleName
    }
}

extension RoleModel {
    func attrStringForRoleName(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: Constants.CellLayout.TagForegroundColor,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: roleName, attributes: attr)
    }
}
