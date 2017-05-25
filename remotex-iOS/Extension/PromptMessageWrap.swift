//
//  PromptMessageWrap.swift
//  remotex-iOS
//
//  Created by archimboldi on 25/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import PromptMessage

class PromptMessageWrap: AnyObject {
    static func show(withMessage text: String) {
        if text.isEmpty {
            return
        }
        DispatchQueue.main.async {
            let message = Message.init(titleText: text, textColor: .white, backgroundColor: UIColor.init(red: 0.97, green: 0.73, blue: 0.18, alpha: 1.0))
            PromptMessage.show(withMessage: message)
        }
    }
}
