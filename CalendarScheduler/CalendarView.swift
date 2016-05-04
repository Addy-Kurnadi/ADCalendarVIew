//
//  CalendarView.swift
//  CalendarScheduler
//
//  Created by Adiwena Kurnadi on 23/03/2016.
//  Copyright © 2016 ASC Software. All rights reserved.
//

import UIKit

struct EventDate {
    let hour : Int;
    let minute : Int;
    let date : Int;
    let timeReference : NSTimeInterval;
}

struct Event {
    let startEvent : EventDate;
    let duration : Int;
    let title : String;
    let description : String;
}

struct HeaderDate {
    let column : Int;
    let date : Int;
    var dateString : String {
        get
        {
            return "\(date)";
        }
    }
    let weekday : String;
}

class CalendarView: UIViewController {
    let cellHeight : CGFloat = 111;
    var cellWidth: CGFloat = 0.0;
    var weekViewCellHeight : CGFloat = 0;
    
    var dictionaryOfEvent : [Int:[Event]] = [:];
    var dictionaryDayToColumn : [Int:Int] = [:];
    
    let weekForDate : NSDate;
    var headerCollectionDate : [HeaderDate] = [];
    let calendar : NSCalendar;
    let dateFormatter : NSDateFormatter;
    
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var scrollView: WeekScrollView!
    @IBOutlet weak var collectionViewCal: UICollectionView!
    @IBOutlet weak var collectionViewHeader: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        self.weekForDate = NSDate();
        self.calendar = NSCalendar.currentCalendar();
        self.dateFormatter = NSDateFormatter();
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let result = ADDateFunctions.sevenDaysOfWeek(self.weekForDate);
        self.headerCollectionDate = result.headerDates;
        self.dictionaryDayToColumn = result.indexToDate;
        
        self.addEvent();
        let width = self.scrollView.frame.size.width - CalendarConstant.scrollViewLabelWidth;
        
        self.cellWidth = width/CGFloat(CalendarConstant.weekCalendarColumns);
        let height = CGFloat(CGFloat(CalendarConstant.weekCalendarRows) * self.cellHeight);
        self.weekViewCellHeight = height;
        
        let frameCollectionView = CGRectMake(CalendarConstant.scrollViewLabelWidth, 0, self.scrollView.frame.size.width - CalendarConstant.scrollViewLabelWidth, height);
        self.collectionViewCal.frame = frameCollectionView;
        self.collectionViewCal.backgroundColor = UIColor.clearColor();
        self.collectionViewHeader.backgroundColor = UIColor.clearColor();
        
        self.scrollView.addHourLines();
        self.addDayLines(CalendarConstant.scrollViewLabelWidth - 1, spacing: self.cellWidth);

        self.scrollView.addSubview(self.collectionViewCal);
        self.scrollView.contentSize = self.collectionViewCal.frame.size;
        self.dateFormatter.dateFormat = "MMM";
        
        self.labelMonth.text = self.dateFormatter.stringFromDate(self.weekForDate).uppercaseString;
        
        self.collectionViewCal.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.Old, context: nil);
    }
    
    func addDayLines(startX:CGFloat, spacing:CGFloat)
    {
        var posX : CGFloat = startX;
        for _ in 0...6 {
            let lineFrame = CGRectMake(posX, self.scrollView.frame.minY, 1, self.view.bounds.maxY);
            let lineView = UIView(frame: lineFrame);
            lineView.backgroundColor = CalendarConstant.WeekLineColor;
            
            self.view.addSubview(lineView);
            let maxX = lineFrame.maxX;
            posX = maxX + spacing - 1 ;
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("Finish Rendering Calendar");
    };
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    func addEvent() {
        let data = self.generateMockEvent();
        for obj in data {
            let indexColumn = self.dateToRow(obj.startEvent.date);
            
            if self.dictionaryOfEvent[indexColumn] == nil {
                self.dictionaryOfEvent[indexColumn] = [];
            }
            
            self.dictionaryOfEvent[indexColumn]!.append(obj);
        }
        
    }
    
    func hourToSection(hour:Int) -> Int
    {
        return hour + 1;
    }
    
    func dateToRow(date:Int) -> Int
    {
        var row = 0;

        let headerDate = self.headerCollectionDate.filter { (obj) -> Bool in
            return obj.date == date;
            }.first
        
        if let header = headerDate {
            row = header.column;
        }
        
        return row;
    }
    
    func timelineToIndexPath(eventDate :EventDate) -> NSIndexPath
    {
        let indexColumn = self.dateToRow(eventDate.date);
        return NSIndexPath(forRow: indexColumn, inSection: 0);
    }
    
    func generateMockEvent() -> [Event]
    {
        let date1 = ADDateFunctions.generateDate(day: 1, month: 5, year: 2016, hour: 1, minute: 0)!;
        let date2 = ADDateFunctions.generateDate(day: 1, month: 5, year: 2016, hour: 1, minute: 20)!;
        let date3 = ADDateFunctions.generateDate(day: 1, month: 5, year: 2016, hour: 1, minute: 50)!;
        let date4 = ADDateFunctions.generateDate(day: 1, month: 5, year: 2016, hour: 2, minute: 10)!;

        let eventDate1 = ADDateFunctions.convertDateToEventDate(date1);
        let eventDate2 = ADDateFunctions.convertDateToEventDate(date2);
        let eventDate3 = ADDateFunctions.convertDateToEventDate(date3);
        let eventDate4 = ADDateFunctions.convertDateToEventDate(date4);

        let event1 = Event(startEvent: eventDate1, duration:60, title: "J0001", description: "Perth");
        let event2 = Event(startEvent: eventDate2, duration:60, title: "J0002", description: "Malaga");
        let event3 = Event(startEvent: eventDate3, duration:120, title: "J0003", description: "Como");
        let event4 = Event(startEvent: eventDate4, duration:90, title: "J0004", description: "Leeming");

        return [event1,event2,event3,event4];
    }
}


extension CalendarView : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarConstant.weekCalendarColumns;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCal {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! WeekCell;
            cell.label.text = "";
            cell.backgroundColor = UIColor.clearColor();
            self.addEventToCell(cell, column: indexPath.row);
            return cell;
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! WeekHeaderCell;
            let header = self.headerCollectionDate[indexPath.row];
            cell.labelDay.text = header.weekday;
            cell.labelDate.text = header.dateString;
            cell.backgroundColor = UIColor.clearColor();
            return cell;
        }
    }
    
    func addEventToCell(cell:WeekCell,column:Int) {
        if let events = self.dictionaryOfEvent[column] where events.count > 0 {
            cell.addEventCollections(events);
        }
    }
    

}

extension CalendarView : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width:self.cellWidth-1.5, height: self.weekViewCellHeight);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 1.0, 1.0);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0;
    }
}

