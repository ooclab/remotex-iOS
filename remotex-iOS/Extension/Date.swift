//
//  Date.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation

extension Date {
    static func dateWithRFC3339String(from rfc3339: String) -> Date? {
        if !(rfc3339.hasSuffix("Z")) {
            return nil
        }
        let dateFormatter = DateFormatter()
        if (rfc3339.contains(".")) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        }
        return dateFormatter.date(from: rfc3339) ?? nil
    }
    
    static func RFC3339StringWithDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        return dateFormatter.string(from: date)
    }
}
