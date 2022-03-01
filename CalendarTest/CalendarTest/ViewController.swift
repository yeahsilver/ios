//
//  ViewController.swift
//  CalendarTest
//
//  Created by mac on 2022/02/20.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
    private lazy var calendarView: FSCalendar = { createCalendarView() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setView()
        setLayout()
        
        // Do any additional setup after loading the view.
    }

}

extension ViewController {
    private func createCalendarView() -> FSCalendar {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.locale = Locale(identifier: "ko_KR")
        return calendar
    }
    
    private func setStyle() {
        setCalendarAttributes()
        setCalendarHeader()
        setCalendarWeekDay()
    }
    
    private func setCalendarAttributes() {
        let apperance = calendarView.appearance
        apperance.eventDefaultColor = .yellow
        apperance.eventSelectionColor = .yellow
        apperance.selectionColor = .yellow
        apperance.weekdayTextColor = .black
        apperance.todayColor = .systemYellow
        apperance.titleTodayColor = .yellow
        apperance.todaySelectionColor = .yellow
    }
    
    private func setCalendarHeader() {
        let appearance = calendarView.appearance
        appearance.headerDateFormat = "MMMM"
        appearance.headerTitleColor = .yellow
        appearance.headerTitleFont = .systemFont(ofSize: 24, weight: .bold)
        calendarView.headerHeight = 0.0
    }
    
    private func setCalendarWeekDay() {
        let weekdayView = calendarView.calendarWeekdayView
        weekdayView.weekdayLabels[0].font = .systemFont(ofSize: 14, weight: .bold)
        weekdayView.weekdayLabels[1].font = .systemFont(ofSize: 14, weight: .bold)
        weekdayView.weekdayLabels[2].font = .systemFont(ofSize: 14, weight: .bold)
        weekdayView.weekdayLabels[3].font = .systemFont(ofSize: 14, weight: .bold)
        weekdayView.weekdayLabels[4].font = .systemFont(ofSize: 14, weight: .bold)
        weekdayView.weekdayLabels[5].font = .systemFont(ofSize: 14, weight: .bold)
        weekdayView.weekdayLabels[6].font = .systemFont(ofSize: 14, weight: .bold)
                
        weekdayView.weekdayLabels[0].text = "Sun"
        weekdayView.weekdayLabels[1].text = "Mon"
        weekdayView.weekdayLabels[2].text = "Tue"
        weekdayView.weekdayLabels[3].text = "Wed"
        weekdayView.weekdayLabels[4].text = "Thu"
        weekdayView.weekdayLabels[5].text = "Fri"
        weekdayView.weekdayLabels[6].text = "Sat"
                
        weekdayView.weekdayLabels[0].textColor = UIColor(red: 229/255, green: 60/255, blue: 14/255, alpha: 1.0)
                
        weekdayView.weekdayLabels[6].textColor = UIColor(red: 41/255, green: 8/255, blue: 251/255, alpha: 1.0)
    }
    
    private func setView() {
        view.addSubview(calendarView)
    }
    
    private func setLayout() {
        let calendarConstraints = [
            calendarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            calendarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(calendarConstraints)
    }
}

