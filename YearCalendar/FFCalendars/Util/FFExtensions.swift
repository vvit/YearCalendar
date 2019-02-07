//
//  FFExtensions.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

extension Date {
    var numberOfWeekInMonthCount: Int {

        let calendar = Calendar.current as NSCalendar
        let rangeWeek = calendar.range(of: .weekOfYear, in: .month, for: self as Date)

        return rangeWeek.length
    }

    var numberOfDaysInMonthCount: Int {

        let calendar = Calendar.current as NSCalendar
        let rangeDay = calendar.range(of: .day, in: .month, for: self as Date)

        return rangeDay.length
    }

    func components() -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year, .weekday, .weekOfMonth, .hour, .minute], from: self)// as NSDateComponents
    }

    static func dateWithYear(year: Int, month: Int, day: Int) -> Date? {

        let calendar = Calendar(identifier: .gregorian)
        let comp = Date.componentsWithYear(year: year, month: month, day: day)

        return calendar.date(from: comp)
    }

    static func componentsWithHour(hour: Int, min: Int) -> DateComponents {

        var comp = DateComponents()
        comp.hour = hour
        comp.minute = min

        return comp
    }

    static func componentsWithYear(year: Int, month: Int, day: Int) -> DateComponents {

        var comp = DateComponents()
        comp.year = year
        comp.month = month
        comp.day = day

        return comp
    }

    static func isTheSameDateTheCompA(compA: DateComponents, andCompB compB: DateComponents) -> Bool {

        return compA.day==compB.day && compA.month==compB.month && compA.year==compB.year
    }
}
