//
//  ADDateFunctions.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 5/04/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import Foundation


class ADDateFunctions {
    
    let calendar : NSCalendar;
    
    class var sharedInstance: ADDateFunctions {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ADDateFunctions? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ADDateFunctions()
        }
        return Static.instance!
    }
    
    init()
    {
        self.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!;
        
    }
    
    func generateDate(day day:Int, month:Int, year:Int, hour:Int, minute:Int) -> NSDate?
    {
        let component = NSDateComponents();
        component.day = day;
        component.month = month;
        component.year = year;
        component.hour = hour;
        component.minute = minute;
        
        return self.calendar.dateFromComponents(component);
    }
    
    func convertDateToEventDate(date:NSDate) -> EventDate {
        let component = calendar.components([.Hour, .Minute, .Day], fromDate: date);
        let eventDate = EventDate(hour:component.hour, minute: component.minute, date: component.day, timeReference:date.timeIntervalSinceReferenceDate);
        
        return eventDate;
    }
    
    class func generateDate(day day:Int, month:Int, year:Int, hour:Int, minute:Int) -> NSDate?
    {
        return ADDateFunctions.sharedInstance.generateDate(day: day, month: month, year: year, hour: hour, minute: minute);
    }
    
    class func convertDateToEventDate(date:NSDate) -> EventDate {
        return ADDateFunctions.sharedInstance.convertDateToEventDate(date);
    }
    
    static func sevenDaysOfWeek(date:NSDate) -> (headerDates:[HeaderDate], indexToDate:[Int:Int] ){
        var dates = [HeaderDate]();
        var idx = 0;
        var indexToDate : [Int:Int] = [:];
        
        // Sunday = 1, Monday = 2, etc
        for weekday in 1...7 {
            if let dateOfMonth = self.dayOfCurrentMonth(weekday, date:date)
            {
                let weekdayInString = self.weekdayToString(weekday)
                dates.append(HeaderDate(column:weekday-1, date: dateOfMonth, weekday: weekdayInString));
                indexToDate[idx] = dateOfMonth;
            }
            
            idx += 1;
        }
        
        return (dates, indexToDate);
    }
    
    static func weekdayToString(day:Int) -> String
    {
        switch (day)
        {
        case 1:
            return "Sunday";
        case 2:
            return "Monday";
        case 3:
            return "Tuesday";
        case 4:
            return "Wednesday";
        case 5:
            return "Thursday";
        case 6:
            return "Friday";
        case 7:
            return "Saturday";
        default:
            return "";
        }
    }
    
    static func dayOfCurrentMonth(weekday:Int, date:NSDate) -> Int? {
        if weekday < 1 || weekday > 7 {
            return nil;
        }
        
        let calendar = NSCalendar.currentCalendar();
        let component = calendar.components([.Day,.Weekday], fromDate: date);
        let dayOfWeek = component.weekday
        let dayOfMonth = component.day;
        print("current week \(dayOfWeek), currentMonth \(dayOfMonth)");
        let different = dayOfWeek - weekday;
        
        return dayOfMonth - different;
    }
}