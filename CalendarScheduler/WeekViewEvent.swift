//
//  WeekViewEvent.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 23/03/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

class WeekViewEvent: UIView {
    
    let marginLeftRight : CGFloat = 5;
    let marginTop : CGFloat = 5;
    let spacing : CGFloat = 5;
    let heightLabelTitle : CGFloat = 18;
    
    let labelTitle : UILabel;
    let labelDescription : UILabel;
    
    init(frame: CGRect, color:UIColor) {
        let titleFrame = CGRectMake(marginLeftRight, marginTop, (frame.size.width - 2*marginLeftRight), heightLabelTitle);
        let height = frame.size.height - heightLabelTitle - 2*marginTop - spacing;
        
        let descriptionFrame = CGRectMake(marginLeftRight, (heightLabelTitle + marginTop + spacing), (frame.size.width - 2*marginLeftRight), height - marginTop);
        
        self.labelTitle = UILabel(frame: titleFrame);
        self.labelTitle.textColor = UIColor.darkGrayColor();
        self.labelTitle.numberOfLines = 1;
        self.labelTitle.lineBreakMode = .ByTruncatingTail;
        self.labelTitle.font = UIFont.boldSystemFontOfSize(14.0);
        

        self.labelDescription = UILabel(frame: descriptionFrame);
        self.labelDescription.textColor = UIColor.darkGrayColor();
        self.labelDescription.numberOfLines = 4;
        self.labelDescription.lineBreakMode = .ByWordWrapping;
        self.labelDescription.font = UIFont.systemFontOfSize(13.0);
        super.init(frame: frame);

        self.backgroundColor = color;

        self.addSubview(self.labelTitle);
        self.addSubview(self.labelDescription);
    }

    func setDescription(text:String)
    {
        self.labelDescription.text = text;
        self.labelDescription.sizeToFit();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
