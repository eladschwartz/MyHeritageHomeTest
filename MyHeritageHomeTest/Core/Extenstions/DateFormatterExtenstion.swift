//
//  DateFormatterExtenstion.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

extension DateFormatter
{
    static let timeStampFormatter: DateFormatter = {
            let formatter           = DateFormatter()
            formatter.dateFormat    = "dd-MM-yyyy HH:mm:ss"
            formatter.timeZone      = TimeZone.current
            let locale              = NSLocale.current.languageCode
            formatter.locale        = Locale(identifier: locale ?? "en-us")
            
            return formatter
        }()
}
