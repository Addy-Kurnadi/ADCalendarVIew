//
//  WeekCalendarFunction.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 4/05/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import Foundation
import UIKit

class WeekCalendarFunction {
    
    let maxWidth: CGFloat;
    
    init(columnMaxWidth:CGFloat)
    {
        self.maxWidth = columnMaxWidth;
    }
    
    func computeIntersection(weekViews:[WeekViewEvent]) -> [WeekViewEvent]
    {
        print("number of view to be process : \(weekViews.count)");
        for wView in weekViews {
            print("connecting view id \(wView.id)")
            
            for otherView in weekViews {
                // dont compare own view
                if otherView.id != wView.id {
                    if otherView.intersect(wView) {
                        wView.connectedViews.append(otherView);
                    }
                }
                
            }
            
            print("connectedViews:\(wView.connectedViews.count)")
        }
        
        return weekViews;
    }
    
    func computeDivision(weekViews:[WeekViewEvent]) -> [WeekViewEvent]
    {
        var removeId : [Int] = [];
        for wView in weekViews {
            var division = 0;
            print("processing view division for id \(wView.id)")
            // loop trough connected views to find out division
            for cView in wView.connectedViews {
                print("comparing with connected view \(cView.id)")
                // build collections to compare with the current connected view
                var _allOtherView = Array(wView.connectedViews);
                _allOtherView.append(wView);
                
                if let removeIndx = _allOtherView.indexOf({ (v) -> Bool in
                    return v.id == cView.id
                }) {
                    
                    _allOtherView.removeAtIndex(removeIndx);
                }
                
                for removeIdx in removeId {
                    if let removeIndx = _allOtherView.indexOf({ (v) -> Bool in
                        return v.id == removeIdx
                    }) {
                        
                        _allOtherView.removeAtIndex(removeIndx);
                    }
                }
                
                for _v in _allOtherView {
                    print("going to compare with \(_v.id)");
                }
                
                
                var allSame : Bool = true;
                for ccView in _allOtherView {
                    print("comparing ccView \(ccView.id)")
                    
                    if let _ = cView.connectedViews.filter({ (w) -> Bool in
                        return w.id == ccView.id;
                    }).first {
                    }
                    else {
                        print("no all the same")
                        allSame = false;
                        break;
                    }
                }
                
                
                // if all same then increase division by 1
                if allSame {
                    division += 1;
                }
            }
            
            print("removing view \(wView.id) from computation");
            removeId.append(wView.id);
            
            // set division if it is higher
            print("final division \(division)")
            if wView.division < division {
                print("setting division to wView \(wView.id) with division : \(division)");
                wView.division = division;
            }
            
            // also set all the connected views
            for cView in wView.connectedViews {
                if cView.division < division {
                    cView.division = division;
                }
            }
        }
        
        return weekViews;
    }
    
    func computeWeekEventWidth(weekViews:[WeekViewEvent]) -> [WeekViewEvent]
    {
        for wView in weekViews {
            let width = self.createViewWidth(wView.getDivision());
            wView.width = width;
        }
        
        return weekViews;
    }
    
    func createViewWidth(division:CGFloat) -> CGFloat
    {
        let width = self.maxWidth;
        return width*division;
    }
}