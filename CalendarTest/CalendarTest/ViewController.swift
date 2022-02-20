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
        let calendarView = FSCalendar()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        return calendarView
    }
    
    private func setStyle() {
        
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

