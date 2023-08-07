//
//  Date.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 06.08.2023.
//

import Foundation

extension Date{
    func dateFromString(_ string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate]
        return dateFormatter.date(from: string)
    }
}
