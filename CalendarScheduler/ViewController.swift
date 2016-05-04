//
//  ViewController.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 7/04/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var hourLineSpacingY : CGFloat = 100;
    var hourLineStartY : CGFloat = 20;
    var numberOfLines : Int = 23;
    
    var hourLabelWidth : CGFloat = 80;
    var hourLabelHeight : CGFloat = 20;
    var hourLabelStartY : CGFloat = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lineView = UIView(frame: CGRectMake(20, 20, 400, 1));
        lineView.backgroundColor = CalendarConstant.WeekLineColor;
        lineView.translatesAutoresizingMaskIntoConstraints = false;
        let label = UILabel(frame: CGRectMake(40, 40, 70, 20));
        label.text = "1:00";
        label.font = UIFont.systemFontOfSize(20);
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addSubview(lineView);
        self.view.addSubview(label);
        
        var all = [NSLayoutConstraint]();
        let labelHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|-300-[label(300)]-10-[line]", options: [], metrics: nil, views: ["label":label,"line":lineView]);
        all += labelHorizontal;
        let labelVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[label(50)]", options: [], metrics: nil, views: ["label":label])
        all += labelVertical;
        let consTrailing = NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: lineView, attribute: .Trailing, multiplier: 1.0, constant: 1);
        let consWidth = NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: hourLabelWidth);
        let consHeight = NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: hourLabelHeight);
        
        let consCenterX = NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: lineView, attribute: .CenterY, multiplier: 1.0, constant: 0.0);
        all += [consTrailing, consCenterX,consWidth,consHeight];
        
        self.view.addConstraints(all);
        NSLayoutConstraint.activateConstraints(all);
        
        //        self.addConstraint(constraint);
        //        self.addConstraint(constrainTrailing);
        
        self.view.layoutIfNeeded();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
