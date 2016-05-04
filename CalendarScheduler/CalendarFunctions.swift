//
//  CalendarFunctions.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 3/05/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import Foundation
import UIKit;

class CalendarFunctions {
    class func convert(event event:Event) -> WeekViewEvent {
        let weekView = WeekViewEvent(startEvent: event.startEvent, duration: event.duration, color: UIColor(red:49/255, green:181/255, blue:247/255, alpha:0.5))
        weekView.timeIntervalReference = event.startEvent.timeReference;
        weekView.startEvent = event.startEvent;
        weekView.duration = event.duration;
        weekView.labelTitle.text = event.title;
        weekView.setDescription(event.description);
        
        return weekView;
    }
    
    class func timeToCellPositionY(event:EventDate) -> CGFloat
    {
        let start : CGFloat = 11.0;
        let hour = CGFloat(event.hour);
        let minutes = CGFloat(event.minute);
        
        let hourPos = start + (hour * 101.0);
        let minRate :CGFloat = 100 / 60
        let minPos = minRate * minutes;
        
        let posY = hourPos + minPos;
        
        return posY;
    }
    
    class func miniutesDurationToHeight(durationInMinutes:Int) -> CGFloat
    {
        let minRate :CGFloat = 100 / 60
        let duration = CGFloat(durationInMinutes);
        let height = minRate * duration;
        
        return height;
    }
}