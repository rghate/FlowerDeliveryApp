//
//  Date.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 25/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

extension Date {
    
    struct CalenderComponent {
        var year: Int = 0
        var month: Int = 0
        var day: Int = 0
        
        var monthName: String
    }
    
    
    
    func getCalenderComponent()-> CalenderComponent? {
        var calenderComponent: CalenderComponent? = nil

        let component: Set<Calendar.Component> = [.year, .month, .day,]
        let calendar = Calendar.current
        let units = calendar.dateComponents(component, from: self)
            
        if let year = units.year, let month = units.month, let day = units.day {
            let monthFullName = calendar.monthSymbols[month - 1]
            calenderComponent = CalenderComponent(year: year, month: month, day: day, monthName: monthFullName)
        }
        return calenderComponent
    }
}

//extension Date {
//
////    struct CalenderComponent {
////        var days: Int = 0
////        var hours: Int = 0
////        var minutes: Int = 0
////        var seconds: Int = 0
////    }
//
//    enum IntervalType: String {
//        case Days
//        case Hours
//        case Minutes
//        case Seconds
//        case NONE
//
//        var description: String {
//            self.rawValue.capitalized
//        }
//    }
//
//    var calenderComponent: CalenderComponent {
//        let component: Set<Calendar.Component> = [.year, .month, .day]
//        NSCalendar.current.dateInterval(of: Calendar.Component, for: self)
//    }
//
//    /**
//     function to calculate offset between two dates.
//     returns: CalenderComponent object with calculated offsets in form of days. hours, minuts and seconds.
//     **/
//    func offsetFrom(date: Date) -> CalenderComponent {
//        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
//        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
//
//        var calenderComp = CalenderComponent()
//
//        calenderComp.seconds = difference.second ?? 0
//        calenderComp.minutes = difference.minute ?? 0
//        calenderComp.hours = difference.hour ?? 0
//        calenderComp.days = difference.day ?? 0
//
//        return calenderComp
//    }
//
//}
