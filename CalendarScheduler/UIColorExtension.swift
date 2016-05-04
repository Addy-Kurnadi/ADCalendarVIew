//
//  UIColorExtension.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 2/05/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func lighterColour() -> UIColor?
    {
        let h = UnsafeMutablePointer<CGFloat>.alloc(1);
        let s = UnsafeMutablePointer<CGFloat>.alloc(1);
        let b = UnsafeMutablePointer<CGFloat>.alloc(1);
        let a = UnsafeMutablePointer<CGFloat>.alloc(1);
        
        if self.getHue(h, saturation: s, brightness: b, alpha: a) {
            
            return UIColor(hue: h.memory, saturation: s.memory, brightness: min(b.memory * 1.3, 1.0), alpha: a.memory);
        }
        
        return nil;
    }
    
    func darkerColour() -> UIColor?
    {
        let h = UnsafeMutablePointer<CGFloat>.alloc(1);
        let s = UnsafeMutablePointer<CGFloat>.alloc(1);
        let b = UnsafeMutablePointer<CGFloat>.alloc(1);
        let a = UnsafeMutablePointer<CGFloat>.alloc(1);
        
        if self.getHue(h, saturation: s, brightness: b, alpha: a) {
            return UIColor(hue: h.memory, saturation: s.memory, brightness: b.memory * 0.75, alpha: a.memory);
        }
        
        return nil;
    }
}