//
//  DateExtension.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 10/8/2565 BE.
//

import Foundation

enum DayOfWeek: Int, CaseIterable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
}

extension Calendar {

    static var appCalendar: Calendar {
        return Calendar.current
    }

    static var gregorianCalendar: Calendar {
        let calendar = Calendar(identifier: Identifier.gregorian)
        return calendar
    }

}

extension Date {

    static func createBy(day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.calendar = Calendar.appCalendar
        dateComponents.timeZone = Calendar.appCalendar.timeZone
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0

        return Calendar.appCalendar.date(from: dateComponents)
    }

    static func createBy(hour: Int, minute: Int) -> Date? {
        let now = Date()
        var dateComponents = DateComponents()
        dateComponents.year = now.year
        dateComponents.month = now.month
        dateComponents.day = now.day
        dateComponents.calendar = Calendar.appCalendar
        dateComponents.timeZone = Calendar.appCalendar.timeZone
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0

        return Calendar.appCalendar.date(from: dateComponents)
    }

    static func createBy(ticks ticksValue: Int64) -> Date {
        let tickFactor: Double = 10000000
        let seconds: Double = Double(ticksValue - 621355968000000000) / tickFactor;
        return Date(timeIntervalSince1970: seconds)
    }

    var midnight: Date? {
        return setTime(hour: 0, minute: 0)
    }

    var day: Int {
        return Calendar.appCalendar.component(.day,  from: self)
    }

    var month: Int {
        return Calendar.appCalendar.component(.month,  from: self)
    }

    var year: Int {
        return Calendar.appCalendar.component(.year,  from: self)
    }

    var gregorianYear: Int {
        return Calendar.gregorianCalendar.component(.year,  from: self)
    }

    var dayOfWeek: DayOfWeek {
        let day = Calendar.appCalendar.component(.weekday,  from: self)
        return DayOfWeek(rawValue: day) ?? .sunday
    }

    var hour: Int {
        return Calendar.appCalendar.component(.hour,  from: self)
    }

    var minute: Int {
        return Calendar.appCalendar.component(.minute,  from: self)
    }

    var totalMinuteOfDay: Int {
        return (hour * 60) + minute
    }

    var isToday: Bool {
        return Calendar.appCalendar.isDateInToday(self)
    }

    var sundayOfWeek: Date? {
        let dayOfWeek = self.dayOfWeek
        guard dayOfWeek != .sunday else {
            return self
        }
        return self.addDay(-(dayOfWeek.rawValue - 1))
    }

    var ticks: Int64 {
        let tickFactor: Double = 10000000
        let tickValue = Int64(floor(self.timeIntervalSince1970 * tickFactor) + 621355968000000000)
        return tickValue;
    }

    var age: Int {
        let now = Date()
        let calendar = Calendar.appCalendar
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        return ageComponents.year!
    }

    func addYear(_ year: Int) -> Date? {
        return Calendar.appCalendar.date(byAdding: .year, value: year, to: self)
    }

    func addMonth(_ month: Int) -> Date? {
        return Calendar.appCalendar.date(byAdding: .month, value: month, to: self)
    }

    func addDay(_ day: Int) -> Date? {
        return Calendar.appCalendar.date(byAdding: .day, value: day, to: self)
    }

    func addHour(_ hour: Int) -> Date? {
        return Calendar.appCalendar.date(byAdding: .hour, value: hour, to: self)
    }

    func addMinute(_ minute: Int) -> Date? {
        return Calendar.appCalendar.date(byAdding: .minute, value: minute, to: self)
    }

    func addSecond(_ second: Int) -> Date? {
        return Calendar.appCalendar.date(byAdding: .second, value: second, to: self)
    }

    func roundUpTo5Minute() -> Date? {
        var addMinute = 5 - (minute % 5)
        if addMinute == 5 {
            addMinute = 0
        }
        return Calendar.appCalendar.date(byAdding: .minute, value: addMinute, to: self)
    }

    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }

    func setTime(hour: Int, minute: Int) -> Date? {
        return Calendar.appCalendar.date(bySettingHour: hour, minute: minute, second: 0, of: self)
    }

}

extension Date {

    var appDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.appCalendar
        dateFormatter.locale = Calendar.appCalendar.locale
        dateFormatter.timeZone = Calendar.appCalendar.timeZone
        return dateFormatter
    }

    func timeFormat() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .timeFormat
        return dateFormatter.string(from: self)
    }

    func time24Format() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .timeHHmmFormat
        return dateFormatter.string(from: self)
    }

    func dateOfMonth() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .dateOfMonth
        return dateFormatter.string(from: self)
    }

    func monthName() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .monthNameFormat
        return dateFormatter.string(from: self)
    }

    func dayOfWeekString() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .dayOfWeek
        return dateFormatter.string(from: self)
    }

    func dateTextFormat() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .date
        return dateFormatter.string(from: self)
    }

    func dateTextFormatWithMonthName() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .dateWithMonthName
        return dateFormatter.string(from: self)
    }

    func dateTextFormatWithTime() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .dateAndTime
        return dateFormatter.string(from: self)
    }

    func dateTimeFormat() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .dateTime
        return dateFormatter.string(from: self)
    }

    func jobDateFormat() -> String {
        let dateFormatter = appDateFormatter
        dateFormatter.dateFormat = .jobDate
        return dateFormatter.string(from: self)
    }

    func rangeToDateFormat(toDate: Date) -> String {
        let df = DateIntervalFormatter()
        df.calendar = Calendar.appCalendar
        df.locale = Calendar.appCalendar.locale
        df.timeZone = Calendar.appCalendar.timeZone
        df.dateTemplate = .rangeDate
        return df.string(from: self, to: toDate)
    }

    func rangeToTimeFormat(toDate: Date) -> String {
        let startTime = self.time24Format()
        let endTime = toDate.time24Format()
        return "\(startTime) - \(endTime)"
    }
}

fileprivate extension String {
    static let timeFormat = "h:mm a"
    static let timeHHmmFormat = "HH:mm"
    static let monthNameFormat = "MMM"
    static let dayOfWeek = "EEE"
    static let dateOfMonth = "dd"
    static let date = "dd.MM.yyyy"
    static let jobDate = "dd MMM yyyy"
    static let dateTime = "dd MMM yyyy HH:mm:ss"
    static let dateWithMonthName = "dd MMM yyyy"
    static let dateAndTime = "yyyy-MM-dd HH:mm:ss"
    static let rangeDate = "yMMMd"
}
