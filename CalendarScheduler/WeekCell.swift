//
//  WeekCell.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 23/03/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

class WeekCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    var weekViews : [WeekViewEvent] = [];
    var currentTag : Int = 0;
    
    
    func timeToCellPositionY(event:EventDate) -> CGFloat
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
    
    func miniutesDurationToHeight(durationInMinutes:Int) -> CGFloat
    {
        let minRate :CGFloat = 100 / 60
        let duration = CGFloat(durationInMinutes);
        let height = minRate * duration;
        
        return height;
    }
    
    func addEventCollections(eventCollections:[Event])
    {
        var _weekViews : [WeekViewEvent] = [];
        for event in eventCollections {
            let weekView = CalendarFunctions.convert(event: event);
            _weekViews.append(weekView);
        }
        
        
        
        _weekViews.sortInPlace { (w1, w2) -> Bool in
            return w1.startPosY < w2.startPosY;
        }
        
        for (idx,wView) in _weekViews.enumerate() {
            wView.id = idx;
        }
        
        let function = WeekCalendarFunction(columnMaxWidth: self.frame.width);
        
        function.computeIntersection(_weekViews);
        function.computeDivision(_weekViews);
        function.computeWeekEventWidth(_weekViews);
        
        self.weekViews = _weekViews;
        
        self.displayWeekViewEvent();
    }
    
    func displayWeekViewEvent()
    {
        var posX : CGFloat = 0;
        for weekView in self.weekViews {
            
            let frame = CGRect(x: posX, y: weekView.startPosY, width: weekView.width, height: weekView.height);
            if weekView.width != self.frame.width {
                let maxX = Int(frame.maxX);
                let frameWidth = Int(self.frame.width);
                
                if maxX != frameWidth  {
                    posX = frame.maxX;
                }
                else {
                    posX = 0
                }
            }
            else {
                posX = 0;
            }
            
            weekView.frame = frame;
            weekView.readjustLabelFrame();
            self.addSubview(weekView);
        }
    }

    
//    func addEventCollections(eventCollections:[Event])
//    {
//        for event in eventCollections {
//            let weekView = CalendarFunctions.convert(event: event);
//            self.weekViews.append(weekView);
//        }
//        
//        self.weekViews.sortInPlace { (w1, w2) -> Bool in
//            return w1.startPosY < w2.startPosY;
//        }
//        
//        for (idx,wView) in self.weekViews.enumerate() {
//            wView.id = idx;
//        }
//        
//        self.computeIntersection();
//        
//        self.computeDivision();
//                
//        for wView in self.weekViews {
//            let width = self.createViewWidth(wView.getDivision());
//            wView.width = width;
//        }
//        
//            
//        self.displayWeekViewEvent();
//    }
//    
//    func computeIntersection()
//    {
//        print("number of view to be process : \(self.weekViews.count)");
//        for wView in self.weekViews {
//            print("connecting view id \(wView.id)")
//            
//            for otherView in self.weekViews {
//                // dont compare own view
//                if otherView.id != wView.id {
//                    if otherView.intersect(wView) {
//                        wView.connectedViews.append(otherView);
//                    }
//                }
//                
//            }
//            
//            print("connectedViews:\(wView.connectedViews.count)")
//        }
//    }
//    
//    func computeDivision()
//    {
//        var removeId : [Int] = [];
//        for wView in self.weekViews {
//            var division = 0;
//            print("processing view division for id \(wView.id)")
//            // loop trough connected views to find out division
//            for cView in wView.connectedViews {
//                print("comparing with connected view \(cView.id)")
//                // build collections to compare with the current connected view
//                var _allOtherView = Array(wView.connectedViews);
//                _allOtherView.append(wView);
//                
//                if let removeIndx = _allOtherView.indexOf({ (v) -> Bool in
//                    return v.id == cView.id
//                }) {
//                    
//                    _allOtherView.removeAtIndex(removeIndx);
//                }
//                
//                for removeIdx in removeId {
//                    if let removeIndx = _allOtherView.indexOf({ (v) -> Bool in
//                        return v.id == removeIdx
//                    }) {
//                        
//                        _allOtherView.removeAtIndex(removeIndx);
//                    }
//                }
//                
//                for _v in _allOtherView {
//                    print("going to compare with \(_v.id)");
//                }
//                
//
//                var allSame : Bool = true;
//                for ccView in _allOtherView {
//                    print("comparing ccView \(ccView.id)")
//                    
//                    if let _ = cView.connectedViews.filter({ (w) -> Bool in
//                        return w.id == ccView.id;
//                    }).first {
//                    }
//                    else {
//                        print("no all the same")
//                        allSame = false;
//                        break;
//                    }
//                }
//                
//                
//                // if all same then increase division by 1
//                if allSame {
//                    division += 1;
//                }
//            }
//            
//            print("removing view \(wView.id) from computation");
//            removeId.append(wView.id);
//            
//            // set division if it is higher
//            print("final division \(division)")
//            if wView.division < division {
//                print("setting division to wView \(wView.id) with division : \(division)");
//                wView.division = division;
//            }
//            
//            // also set all the connected views
//            for cView in wView.connectedViews {
//                if cView.division < division {
//                    cView.division = division;
//                }
//            }
//        }
//    }
//    
//
//    func findIntersectWeekView(frame frame:CGRect) -> [WeekViewEvent]
//    {
//        var intersectViews : [WeekViewEvent] = [];
//        
//        for view in self.weekViews {
//            if view.frame.intersects(frame) {
//                intersectViews.append(view);
//            }
//            if let neighbourView = view.leftNeighbourView {
//                intersectViews.append(neighbourView);
//            }
//        }
//        
//        let set : Set<WeekViewEvent> = Set<WeekViewEvent>(intersectViews);
//        
//        return Array(set);
//    }
//    
//    func createViewWidth(division:CGFloat) -> CGFloat
//    {
//        let width = self.frame.width;
//        return width*division;
//    }
   
    
    
}
