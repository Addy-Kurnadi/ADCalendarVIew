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

    var numberOfCell : Int = 0;
    let numberOfRows : Int = 25;
    let numberOfColumns : Int = 7;
    let cellHeight : CGFloat = 100;
    var cellWidth: CGFloat = 0.0;
    let tableViewWidth : CGFloat = 80;
    
    var dictionaryOfEvent : [NSIndexPath:[Event]] = [:];
    
    let weekForDate : NSDate;
    var headerCollectionDate : [HeaderDate] = [];
    
    let calendar : NSCalendar;
    let dateFormatter : NSDateFormatter;
    
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var tableViewHours: UITableView!
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
        self.headerCollectionDate = ADDateFunctions.sevenDaysOfWeek(self.weekForDate);

        self.addEvent();

        let width = self.scrollView.frame.size.width - tableViewWidth;
        self.numberOfCell = self.numberOfRows * self.numberOfColumns;
        
        self.cellWidth = width/CGFloat(self.numberOfColumns);
        let height = CGFloat(CGFloat(numberOfRows) * self.cellHeight);
        
        let shiftUp:CGFloat = (self.cellHeight / 2) - 20;
        let frameTableViewHour = CGRectMake(0, -shiftUp, tableViewWidth, height+shiftUp);
        self.tableViewHours.frame = frameTableViewHour;
        
        let frameCollectionView = CGRectMake(tableViewWidth, -80, self.scrollView.frame.size.width - tableViewWidth, height);
        self.collectionViewCal.frame = frameCollectionView;
        
        self.scrollView.addSubview(self.collectionViewCal);
        self.scrollView.addSubview(self.tableViewHours);
        
        self.scrollView.contentSize = self.collectionViewCal.frame.size;
        
        
        self.dateFormatter.dateFormat = "MMM";
        
        self.labelMonth.text = self.dateFormatter.stringFromDate(self.weekForDate).uppercaseString;
        
        self.collectionViewCal.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.Old, context: nil);
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
            let indexPath = self.timelineToIndexPath(obj.startEvent);
            self.dictionaryOfEvent[indexPath] = [obj];
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
        return NSIndexPath(forRow: self.dateToRow(eventDate.date), inSection: self.hourToSection(eventDate.hour));
    }
    
    func generateMockEvent() -> [Event]
    {
        let date1 = ADDateFunctions.generateDate(day: 6, month: 4, year: 2016, hour: 3, minute: 10)!;
        let date2 = ADDateFunctions.generateDate(day: 5, month: 4, year: 2016, hour: 5, minute: 10)!;
        let date3 = ADDateFunctions.generateDate(day: 7, month: 4, year: 2016, hour: 7, minute: 10)!;
        
        let eventDate1 = ADDateFunctions.convertDateToEventDate(date1);
        let eventDate2 = ADDateFunctions.convertDateToEventDate(date2);
        let eventDate3 = ADDateFunctions.convertDateToEventDate(date3);
        
        let event1 = Event(startEvent: eventDate1, duration:60, title: "J2310", description: "Wednesday");
        let event2 = Event(startEvent: eventDate2, duration:60, title: "J2310", description: "Tuesday");
        let event3 = Event(startEvent: eventDate3, duration:60, title: "J2310", description: "Thursday");
        
        return [event1,event2,event3];
    }
}


extension CalendarView : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionViewCal {
            return self.numberOfRows;
        }
        else {
            return 1;
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfColumns;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCal {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! WeekCell;

            cell.label.text = "";
            self.addEventToCell(cell, indexPath: indexPath);
            return cell;
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! WeekHeaderCell;
            let header = self.headerCollectionDate[indexPath.row];
            cell.labelDay.text = header.weekday;
            cell.labelDate.text = header.dateString;
            
            return cell;
        }
    }
    
    func addEventToCell(cell:WeekCell,indexPath:NSIndexPath) {
        if let _ = self.dictionaryOfEvent[indexPath] {
            let frame = cell.frame;
            let viewEvent = WeekViewEvent(frame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height), color: UIColor(red:49/255, green:181/255, blue:247/255, alpha:0.5));
            viewEvent.labelTitle.text = "J232314"
            viewEvent.setDescription("ADEVE Co\n1 Murray St, Perth, WA 6000");
            self.collectionViewCal.addSubview(viewEvent);
        }
    }
}

extension CalendarView : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width:self.cellWidth-1.5, height: self.cellHeight);
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


extension CalendarView : UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRows - 1;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.cellHeight + 1.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
        let hourText = "\(indexPath.row):00";
        
        cell.textLabel?.text = hourText;
        
        return cell;
    }
}

