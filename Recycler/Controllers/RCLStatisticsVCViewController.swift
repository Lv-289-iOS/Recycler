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
    
//    var testArray  :[Double] = []
//    var numbersForGlass : [Double] = [9,3,5,12,24,16,9]
//    var numbersForBatteries : [Double] = [1,5,10,6,14,10,11]
//    var numbersForOrganic : [Double] = [2,3,8,2,4,12,21]
//    var numbersForPlastic: [Double] = [3,4,9,2,9,17,13]
//    var numbersForPaper :   [Double] = [7,10,15,2,10,11,15]
//    var numbersForMetal :   [Double] = [13,4,0,2,1,25,20]
    var testArray2:[[Double]] = [[9,3,5,12,24,16,9],[1,5,10,6,14,10,11],[2,3,8,2,4,12,21],[3,4,9,2,9,17,13],[7,10,15,2,10,11,15],[13,4,0,2,1,25,20]]
    
    //print("DAY 1 =", numbersForGlass)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         numbersForGlass = date()
//        print(numbersForGlass)
    
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"n", style:.plain, target:nil, action:nil)
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGraph(){
        //Array that will be displayed on the graph.
        var lines3 = [LineChartDataSet]()
        
        //testArray2 = [numbersForGlass]
//        testArray2.append(numbersForBatteries)
//        testArray2.append(numbersForOrganic)
//        testArray2.append(numbersForPlastic)
//        testArray2.append(numbersForPaper)
//        testArray2.append(numbersForMetal)
        print("testArray2.count \(testArray2.count) testArray2[1].count \(testArray2[1].count)")
        
        var labels = ["Plastic","Plastic1","Plastic2","Plastic","Plastic","Plastic"]
        for i in 0..<testArray2.count {
            var entrie = [ChartDataEntry]()
//            print(testArray2[i])
            for j in 0..<testArray2[1].count {
//                entries[i][j] = ChartDataEntry(x: Double(i), y: testArray2[i][j])
                entrie.append(ChartDataEntry(x: Double(j), y: testArray2[i][j]))
                print(entrie)
            }
            lines3.append(LineChartDataSet(values: entrie, label: labels[i]))
//            print("test \(lines3[i])")
        }
//        entries[0][0] = ChartDataEntry(x: Double(1), y: numbersForPlastic[1])
        
        
//        var lineChartEntryPlastic = [ChartDataEntry]()
//        var lineChartEntryPaper   = [ChartDataEntry]()
//        var lineChartEntryMetal   = [ChartDataEntry]()
//        var lineChartEntryBatteries = [ChartDataEntry]()
//        var lineChartEntryOrganic = [ChartDataEntry]()
//        var lineChartEntryGlass = [ChartDataEntry]()
//        
//        for i in 0..<daysInWeek {
//            //set the X and Y status in a data chart entry
//            let valueForPlastic = ChartDataEntry(x: Double(i), y: numbersForPlastic[i])
//            let valueForPaper   = ChartDataEntry(x: Double(i), y: numbersForPaper  [i])
//            let valueForMetal   = ChartDataEntry(x: Double(i), y: numbersForMetal  [i])
//            let valueForGlass   = ChartDataEntry(x: Double(i), y: numbersForGlass  [i])
//            let valueForBatteries = ChartDataEntry(x: Double(i), y: numbersForBatteries  [i])
//            let valueForOrganic = ChartDataEntry(x: Double(i), y: numbersForOrganic  [i])
//            
//            // here we add it to the data set
//            lineChartEntryPlastic.append(valueForPlastic)
//            lineChartEntryPaper.append(valueForPaper)
//            lineChartEntryMetal.append(valueForMetal)
//            lineChartEntryBatteries.append(valueForBatteries)
//            lineChartEntryGlass.append(valueForGlass)
//            lineChartEntryOrganic.append(valueForOrganic)
//        }
        
        // write in zip
        //Here we convert lineChartEntry to a LineChartDataSet
        
//        let line1 = LineChartDataSet(values: lineChartEntryPlastic, label: "Plastic")
//        let line2 = LineChartDataSet(values: lineChartEntryPaper, label: "Paper")
//        let line3 = LineChartDataSet(values: lineChartEntryMetal, label: "Metal")
//        let line4 = LineChartDataSet(values: lineChartEntryBatteries, label: "Batteries")
//        let line5 = LineChartDataSet(values: lineChartEntryGlass, label: "Glass")
//        let line6 = LineChartDataSet(values: lineChartEntryOrganic, label: "Organic")
        //Sets the colours
        
//        let lines = [line1, line2, line3, line4, line5, line6]
        let colors = [NSUIColor.blue, NSUIColor.yellow,NSUIColor.red,NSUIColor.cyan,NSUIColor.black,NSUIColor.darkGray]
        
        
        let data = LineChartData()
        _ = zip(lines3, colors).compactMap {
            $0.0.colors = [$0.1]
            $0.0.valueTextColor = $0.1
            data.addDataSet($0.0)
        }
        
//        let zipOfColors = zip(linesColors,colors)
//        zipOfColors.map{ $0.0 = $1.0 }
        
//        let materials  = [plastic, metal, organic, batteries, glass, paper]
//
//        let colors = [UIColor.Charts.Color0, UIColor.Charts.Color1, UIColor.Charts.Color2, UIColor.Charts.Color3, UIColor.Charts.Color4, UIColor.Charts.Color5]
//
//        return zip(materials, colors).flatMap { $0.0 > 0 ?
//            PieSliceModel(value: Double($0.0), color: $0.1) : nil
//        }
        
//        line1.colors = [NSUIColor.blue]
//        line2.colors = [NSUIColor.yellow]
//        line3.colors = [NSUIColor.red]
//        line4.colors = [NSUIColor.cyan]
//        line5.colors = [NSUIColor.black]
//        line6.colors = [NSUIColor.darkGray]
//
//        line1.valueTextColor = NSUIColor.blue
//        line2.valueTextColor = NSUIColor.yellow
//        line3.valueTextColor = NSUIColor.red
//        line4.valueTextColor = NSUIColor.cyan
//        line5.valueTextColor = NSUIColor.black
//        line6.valueTextColor = NSUIColor.darkGray
        
        //This is the object that will be added to the chart
//        let data = LineChartData()
//
//        data.addDataSet(line1) //Adds the line to the dataSet
//        data.addDataSet(line2)
//        data.addDataSet(line3)
//        data.addDataSet(line4)
//        data.addDataSet(line5)
//        data.addDataSet(line6)
        
        //it adds the chart data to the chart and causes an update
        lineChartView.data = data
    }
}
