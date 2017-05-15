//
//  NumberFormatter.swift
//  remotex-iOS
//
//  Created by Niangzi&Xianggong on 15/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func formatRMBCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "¥"
        formatter.locale = Locale.current
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
}
