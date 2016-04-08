//
//  HourLine.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 6/04/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

class HourLine: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        let context = UIGraphicsGetCurrentContext();

        
        CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor);
        CGContextFillRect(context, self.bounds);
        
        CGContextSetStrokeColorWithColor(context, UIColor.darkGrayColor().CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextMoveToPoint(context, rect.minX, rect.midY);
        CGContextAddLineToPoint(context, rect.maxX, rect.midY);
        CGContextStrokePath(context);
    }

}
