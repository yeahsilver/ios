//
//  ViewController.swift
//  ChartTest
//
//  Created by mac on 2022/01/14.
//

import UIKit

import Charts

class ViewController: UIViewController {
    
    private lazy var pieChartView: PieChartView = { createPieChartView() }()
    
    let parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F",
                   "Party G", "Party H", "Party I", "Party J", "Party K", "Party L",
                   "Party M", "Party N", "Party O", "Party P", "Party Q", "Party R",
                   "Party S", "Party T", "Party U", "Party V", "Party W", "Party X",
                   "Party Y", "Party Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(pieChartView: pieChartView)
        setLayout()
        setDataCount(5, range: 5)
        // Do any additional setup after loading the view.
    }
    
    private func createPieChartView() -> PieChartView {
        let chart = PieChartView()
        chart.entryLabelColor = .white
        chart.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(chart)
        return chart
    }
    
    
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.48
        chartView.transparentCircleRadiusPercent = 0.51
        chartView.chartDescription?.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = false
        chartView.highlightPerTapEnabled = true
        
//        chartView.drawEntryLabelsEnabled = !chartView.drawEntryLabelsEnabled
        chartView.animate(xAxisDuration: 0.5, easingOption: .easeInCirc)
        chartView.setNeedsDisplay()
        
        chartView.legend.enabled = false
    }
    
    private func setLayout() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            pieChartView.topAnchor.constraint(equalTo: guide.topAnchor),
            pieChartView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            pieChartView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            pieChartView.leadingAnchor.constraint(equalTo: guide.leadingAnchor)
        ])
    }
    
    private func setDataCount(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(entries: entries, label: "Election Results")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        set.sliceSpace = 2
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        pieChartView.data = data
        pieChartView.highlightValues(nil)
    }
}
