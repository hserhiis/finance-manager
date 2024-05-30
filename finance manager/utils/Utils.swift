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
        
        if self >= 1000 {
            let formattedString = numberFormatter.string(from: NSNumber(value: self))!
            return formattedString
        } else {
            return numberFormatter.string(from: NSNumber(value: self))!
        }
    }
}

func getDeletedComma(value: String) -> String {
    let valueWithoutComma =  value.replacingOccurrences(of: ",", with: " ")
    return valueWithoutComma.replacingOccurrences(of: ".", with: " ")
}


let doubleSpecifier: String = "%.2f"

// functionality for format date for different needs
func formattedDateOnly(from date: Date, dateType: DateType, dayType: DayType?) -> String {
    var dateString: String {
        switch dateType {
        case .monthDay: return "dd.MM"
        case .yearMonthDay: return "dd.MM.yyyy"
        }
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateString
    
    if let dayType = dayType {
        if dayType == .today {
            return dateFormatter.string(from: date)
        } else if dayType == .yesterday {
            // Get the calendar and calculate yesterday's date
            let calendar = Calendar.current
            let modifiedDate = calendar.date(byAdding: .day, value: -1, to: date)!
            return dateFormatter.string(from: modifiedDate)
        } else {
            let calendar = Calendar.current
            let modifiedDate = calendar.date(byAdding: .day, value: -2, to: date)!
            return dateFormatter.string(from: modifiedDate)
        }
    } else {
        // If dayType is nil, return the date without modification
        return dateFormatter.string(from: date)
    }
}

func getIsValidEmail(value: String) -> Bool {
    let emailRegex = try! NSRegularExpression(pattern: "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")
    return emailRegex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.utf16.count)) != nil
}


func getIsValidPassword(value: String) -> Bool {
    if value.count >= 8 {
        return true
    } else {
        return false
    }
}

func getIsValidConfirmedPassword(password: String, confirmedPassword: String) -> Bool {
    if password == confirmedPassword {
        return true
    } else {
        return false
    }
}

let currentDate = Date()

// formatted date for DateWidgetView
var todayDate: String = formattedDateOnly(from: Date.now, dateType: .monthDay, dayType: .today)
var yesterdayDate: String = formattedDateOnly(from: Date.now, dateType: .monthDay, dayType: .yesterday)
var beforeYesterdayDate: String = formattedDateOnly(from: Date.now, dateType: .monthDay, dayType: .beforeYesterday)

var todayString: String = DayType.today.day
var yesterdayString: String = DayType.yesterday.day
var beforeYesterdayString: String = DayType.beforeYesterday.day
