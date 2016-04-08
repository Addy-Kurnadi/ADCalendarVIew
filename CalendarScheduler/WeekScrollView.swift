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
    
    var hourLineSpacingY : CGFloat = 100;
    var hourLineStartY : CGFloat = 10;
    var numberOfLines : Int = 23;
    
    var hourLabelWidth : CGFloat = 60;
    var hourLabelHeight : CGFloat = 21;
    var hourLabelStartY : CGFloat = 20;
    
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
        var posY : CGFloat = self.hourLineStartY;
        for hour in 0...self.numberOfLines {
            
            let labelFrame = CGRectMake(self.bounds.minX + WeekSVConstant.leftSpacing, posY, self.hourLabelWidth, self.hourLabelHeight);
            let label = UILabel(frame: labelFrame);
            label.text = "\(hour):00";
            label.font = UIFont.systemFontOfSize(14);
            
            let lineFrame = CGRectMake(label.frame.maxX + WeekSVConstant.labelLineSpacing , posY + 11, self.bounds.maxX, 1);
            let lineView = UIView(frame: lineFrame);
            lineView.backgroundColor = UIConstant.WeekLineColor;
            
            
            
            self.addSubview(lineView);
            self.addSubview(label);
            
            let maxY = lineFrame.maxY;
            posY = maxY + hourLineSpacingY;
        }
    }
    
    func addHourLabel()
    {
        var posY : CGFloat = self.hourLineStartY - (self.hourLabelHeight / 2);
        let labelSpacing : CGFloat = self.hourLineSpacingY - self.hourLabelHeight;
        
        for hour in 0...self.numberOfLines {
            let frame = CGRectMake(self.bounds.minX + WeekSVConstant.leftSpacing, posY, self.hourLabelWidth, self.hourLabelHeight);
            let label = UILabel(frame: frame);
            label.text = "\(hour):00";
            label.font = UIFont.systemFontOfSize(14);
            
            self.addSubview(label);
            posY = frame.maxY + labelSpacing;
        }
    }
}
