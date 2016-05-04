//
//  WeekScrollView.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 6/04/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

struct WeekSVConstant {
    static let leftSpacing : CGFloat = 15;
    static let labelLineSpacing : CGFloat = 8;
}

class WeekScrollView: UIScrollView {
//    func addHourLines()
//    {
//        var posY : CGFloat = self.hourLineStartY;
//        let lineView = UIView(frame: CGRectZero);
//        lineView.backgroundColor = UIConstant.WeekLineColor;
//        lineView.translatesAutoresizingMaskIntoConstraints = false;
//        
//        let label = UILabel(frame: CGRectZero);
//        label.text = "1:00";
//        label.font = UIFont.systemFontOfSize(14);
//        label.translatesAutoresizingMaskIntoConstraints = false;
//        label.backgroundColor = UIColor.lightGrayColor();
//        self.addSubview(lineView);
//        self.addSubview(label);
//        
//        var all = [NSLayoutConstraint]();
//        let labelHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[label]-10@100-|", options: [], metrics: nil, views: ["label":label]);
//        all += labelHorizontal;
////        let lineHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:[label]-10-[line]-10-|", options: [], metrics: nil, views: ["label":label,"line":lineView]);
////        all += lineHorizontal;
//        let labelVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[label(20)]", options: [], metrics: nil, views: ["label":label])
//        all += labelVertical;
//        let lineVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[line]", options: [], metrics: nil, views: ["line":lineView]);
//        all += lineVertical;
//        
////        let consCenterX = NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: lineView, attribute: .CenterY, multiplier: 1.0, constant: 0.0);
//        let lineHeight = NSLayoutConstraint(item: lineView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 50.0);
//        let trailingLine = NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 1.0);
//        
//        all += [lineHeight,trailingLine];
//        
//        NSLayoutConstraint.activateConstraints(all);
//        
////        self.addConstraint(constraint);
////        self.addConstraint(constrainTrailing);
//        
//        self.layoutSubviews();
//    }
    
    func addHourLines()
    {
        var posY : CGFloat = CalendarConstant.hourLineStartY;
        for hour in 0...CalendarConstant.numberOfLines {
            
            let lineFrame = CGRectMake(CalendarConstant.hourLabelWidth + WeekSVConstant.labelLineSpacing , posY, self.bounds.maxX, 1);
            let lineView = UIView(frame: lineFrame);
            lineView.backgroundColor = CalendarConstant.WeekLineColor;
            
            let labelFrame = CGRectMake(self.bounds.minX + WeekSVConstant.leftSpacing, posY - 11, CalendarConstant.hourLabelWidth, CalendarConstant.hourLabelHeight);
            let label = UILabel(frame: labelFrame);
            label.text = "\(hour):00";
            label.font = UIFont.systemFontOfSize(14);
            
            self.addSubview(lineView);
            self.addSubview(label);
            
            let maxY = lineFrame.maxY;
            posY = maxY + CalendarConstant.hourLineSpacingY;
        }
    }
    
    func addDayLines(startX:CGFloat, spacing:CGFloat)
    {
//        let ceilSpacing = ceil(spacing);
        var posX : CGFloat = startX;
        for _ in 0...6 {
            let lineFrame = CGRectMake(posX, 0, 1, self.bounds.maxY);
            let lineView = UIView(frame: lineFrame);
            lineView.backgroundColor = CalendarConstant.WeekLineColor;
            
            self.addSubview(lineView);
            let maxX = lineFrame.maxX;
            posX = maxX + spacing - 1 ;
        }
    }
}
