//
//  RCLStatisticsVCViewController.swift
//  Recycler
//
//  Created by Володимир Смульський on 3/15/18.
//  Copyright © 2018 softserve.university. All rights reserved.

import UIKit
import Charts

class RCLStatisticsVCViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    
    var daysInWeek = 7
//    func date() -> [Double] {
//
//        let date = Date()
//        var components = DateComponents()
//        let calendar = Calendar.current
//        components.year = calendar.component(.year, from: date)
//        components.month = calendar.component(.month, from: date)
//        components.day = calendar.component(.day, from: date) - 1
//        components.hour = 0
//        components.minute = 0
//        components.second = 0
//        let newDate = calendar.date(from: components)
//        print("Date  \(newDate!)!!!!!!!!!")
//        FirestoreService.shared.getTrashBy(oneDay: newDate!) { trashList in
//            print(trashList.count)
//        }
//
//        for i  in 0..<daysInWeek {
//            components.day = calendar.component(.day, from: date) + i
//            FirestoreService.shared.getTrashBy(oneDay: newDate! + TimeInterval(i)) { trashList in
//                //print(trashList.count)
//                self.numbersForGlass += [Double(trashList.count)]
//            }
//        }
//        return numbersForGlass
//    }
    
    var testArray2:[[Double]] = [[9,3,5,12,24,16,9],[1,5,10,6,14,10,11],[2,3,8,2,4,12,21],[3,4,9,2,9,17,13],[7,10,15,2,10,11,15],[13,4,0,2,1,25,20]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGraph()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    self.navigationController?.navigationBar.isHidden = false
    }
    
    func updateGraph(){
        var lines = [LineChartDataSet]()
        var labels = ["Plastic","Glass","Batteries","Organic","Paper","Metal"]
        
        for i in 0..<testArray2.count {
            var entrie = [ChartDataEntry]()
            for j in 0..<testArray2[1].count {
                entrie.append(ChartDataEntry(x: Double(j), y: testArray2[i][j]))
            }
            lines.append(LineChartDataSet(values: entrie, label: labels[i]))
        }

        let colors = [NSUIColor.blue, NSUIColor.yellow,NSUIColor.red,NSUIColor.cyan,NSUIColor.black,NSUIColor.darkGray]
        
        let data = LineChartData()
        _ = zip(lines, colors).compactMap {
            $0.0.colors = [$0.1]
            $0.0.valueTextColor = $0.1
            data.addDataSet($0.0)
        }
        
        //it adds the chart data to the chart and causes an update
        lineChartView.data = data
    }
}
