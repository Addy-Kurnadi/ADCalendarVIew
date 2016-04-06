//
//  CalendarViewFlowLayout.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 23/03/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

class CalendarViewFlowLayout: UICollectionViewFlowLayout {
    override func collectionViewContentSize() -> CGSize {
        if let _collectionsView = self.collectionView {
            return CGSizeMake(_collectionsView.frame.width, _collectionsView.frame.height);
        }
        
        return CGSizeZero;
    }
}
