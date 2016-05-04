//
//  WeekViewEvent.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 23/03/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

class WeekViewEvent: UIView {
    
    var id : Int = 0;
    var connectedViews : [WeekViewEvent] = [];
    
    let heightLabelTitle : CGFloat = 21;
    var division : Int = 0;
    
    var startPosY : CGFloat = 0;
    var endPosY : CGFloat = 0;
    var height : CGFloat = 0;
    var width : CGFloat = 0;
    
    var timeIntervalReference : NSTimeInterval = 0;
    var startEvent : EventDate;
    var duration : Int;
    
    let labelTitle : UILabel;
    let labelDescription : UILabel;
    var leftNeighbourView : WeekViewEvent?;
    
    init(startEvent:EventDate, duration:Int,color:UIColor) {
        self.startEvent = startEvent;
        self.duration = duration;
        self.timeIntervalReference = self.startEvent.timeReference;
        
        let posY = CalendarFunctions.timeToCellPositionY(self.startEvent);
        let height = CalendarFunctions.miniutesDurationToHeight(self.duration);
        self.startPosY = posY;
        self.height = height;
        self.endPosY = posY + height;
        
        self.labelTitle = UILabel(frame: CGRectZero);
        self.labelTitle.textColor = UIColor.whiteColor();
        self.labelTitle.numberOfLines = 0;
        self.labelTitle.lineBreakMode = .ByWordWrapping;
        self.labelTitle.font = UIFont.boldSystemFontOfSize(13.0);
        self.labelTitle.backgroundColor = color.darkerColour();
    
        
        self.labelDescription = UILabel(frame: CGRectZero);
        self.labelDescription.textColor = UIColor.darkGrayColor();
        self.labelDescription.numberOfLines = 0;
        self.labelDescription.lineBreakMode = .ByWordWrapping;
        self.labelDescription.font = UIFont.systemFontOfSize(13.0);
        
        super.init(frame: CGRectZero);
        
        self.backgroundColor = color;
        self.addSubview(self.labelTitle);
        self.addSubview(self.labelDescription);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func intersect(wViewEvent:WeekViewEvent) -> Bool
    {
        if self.startPosY < wViewEvent.startPosY {
            if wViewEvent.startPosY < self.endPosY {
                return true;
            }
            else {
                return false;
            }
        }
        else {
            if self.startPosY < wViewEvent.endPosY {
                return true;
            }
            else {
                return false;
            }
        }
       
    }
    
    func getDivision() -> CGFloat {
        
        var hasGap = true;
        var connectedViewDivision = 0;
        for cView in self.connectedViews {
            if cView.division != self.division {
                connectedViewDivision = cView.division;
            }
            else {
                hasGap = false;
            }
            
        }
        
        if hasGap {
            let fDiv = CGFloat((self.division + 1));
            let fGDiv = CGFloat(connectedViewDivision + 1);
            let _fDiv = 1.0 / fDiv;
            let _fGDiv = 1.0 / fGDiv;
            
            return _fDiv + (_fDiv - _fGDiv);
        }
        else {
            let fDiv = CGFloat((self.division + 1));
            
            return 1.0 / fDiv;
        }
    }
    
    func readjustLabelFrame()
    {
        let frameForLabel = CGRect(origin: CGPointZero, size: self.frame.size);
        let slice1 = UnsafeMutablePointer<CGRect>.alloc(1);
        let slice2 = UnsafeMutablePointer<CGRect>.alloc(1);
        CGRectDivide(frameForLabel, slice1, slice2, heightLabelTitle, CGRectEdge.MinYEdge);
        
        self.labelTitle.frame = slice1.memory;
        self.labelDescription.frame = slice2.memory;

        slice1.destroy();
        slice1.dealloc(1);
        slice2.destroy();
        slice2.dealloc(1);
        self.labelDescription.sizeToFit();
    }

    func setDescription(text:String)
    {
        self.labelDescription.text = text;
        self.labelDescription.sizeToFit();
    }


    

}
