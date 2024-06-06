//
//  Utils.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
//

import Foundation

extension Double {
    var abbreviated: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

extension Double {
    var short: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.roundingMode = .down

        let thousand = 1000.0
        let million = thousand * thousand

        if self >= million {
            return numberFormatter.string(from: NSNumber(value: self / million))! + "M"
        } else if self >= thousand {
            return numberFormatter.string(from: NSNumber(value: self / thousand))! + "k"
        } else {
            return numberFormatter.string(from: NSNumber(value: self))!
        }
    }
}

func removeCommasAndDots(from value: String) -> String {
    return value.replacingOccurrences(of: ",", with: " ").replacingOccurrences(of: ".", with: " ")
}

let doubleSpecifier: String = "%.2f"

func formattedDate(from date: Date, dateType: DateType, dayType: DayType? = nil) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = {
        switch dateType {
        case .monthDay: return "dd.MM"
        case .yearMonthDay: return "dd.MM.yyyy"
        }
    }()

    guard let dayType = dayType else {
        return dateFormatter.string(from: date)
    }

    let calendar = Calendar.current
    let modifiedDate: Date

    switch dayType {
    case .today:
        modifiedDate = date
    case .yesterday:
        modifiedDate = calendar.date(byAdding: .day, value: -1, to: date)!
    case .beforeYesterday:
        modifiedDate = calendar.date(byAdding: .day, value: -2, to: date)!
    }
    return dateFormatter.string(from: modifiedDate)
}

func getIsValidEmail(_ value: String) -> Bool {
    let emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: value)
}

func getIsValidPassword(_ value: String) -> Bool {
    return value.count >= 8
}

func getIsValidConfirmedPassword(password: String, confirmedPassword: String) -> Bool {
    return password == confirmedPassword
}

let currentDate = Date()

var todayDate: String = formattedDate(from: Date.now, dateType: .monthDay, dayType: .today)
var yesterdayDate: String = formattedDate(from: Date.now, dateType: .monthDay, dayType: .yesterday)
var beforeYesterdayDate: String = formattedDate(from: Date.now, dateType: .monthDay, dayType: .beforeYesterday)

var todayString: String = DayType.today.day
var yesterdayString: String = DayType.yesterday.day
var beforeYesterdayString: String = DayType.beforeYesterday.day
