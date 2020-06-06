//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by KOFI on 6/6/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import Foundation

extension Date{
    func convertToMonthYearFormat()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
