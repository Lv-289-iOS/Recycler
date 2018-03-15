//
//  RCLDashboardVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 02.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit
import PieCharts


class RCLDashboardVC: UIViewController {
    
    let chartView: PieChart = PieChart(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var userTrashCans = [TrashCan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(chartView)
        addTitleLabel(text: "Dashboard")
        buttonCreate()
    }
    
    func getTrashCans(forUser: User) {
        guard let userId = forUser.id else {
            return
        }
        
        FirestoreService.shared.getTrashCansBy(userId: userId) { result in
            self.userTrashCans = result
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        chartView.backgroundColor = UIColor.Backgrounds.GrayDark
        chartView.layers = [createCustomViewsLayer(), createTextLayer()]
        getTrashCans(forUser : currentUser)
        chartView.models = createModels()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    func buttonCreate() {
        
        let button = UIButton(type: UIButtonType.system) as UIButton
        
        let xPostion:CGFloat = 120
        let yPostion:CGFloat = 550
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        button.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        
        button.backgroundColor = UIColor.Button.backgroundColor
        button.setTitle("Statistic", for: UIControlState.normal)
        button.layer.cornerRadius = CGFloat.Design.CornerRadius
        button.tintColor = UIColor.Button.titleColor
        button.addTarget(self, action: #selector(RCLDashboardVC.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        performSegue(withIdentifier: "StatisticsSegue", sender: self)
        print("Button tapped")
    }
    

    fileprivate func createModels() -> [PieSliceModel] {

        var slices = [PieSliceModel]()
        var plastic = 0
        var metal = 0
        var organic = 0
        var batteries = 0
        var glass = 0
        var paper = 0
        
        for trash in self.userTrashCans {
            switch trash.type{
            case "plastic" :
                plastic += trash.size
            case "metal" :
                metal += trash.size
            case "organic" :
                organic += trash.size
            case "battaries" :
                batteries += trash.size
            case "glass" :
                glass += trash.size
            case "paper" :
                paper += trash.size
            default:
                print("none")
            }
    }
        
        if plastic > 0
        {
            let slice = PieSliceModel(value: Double(plastic), color: UIColor.yellow, obj: RCLTrashType.plastic)
              slices.append(slice)
        }
        
        if metal > 0 {
            let slice = PieSliceModel(value: Double(metal), color: UIColor.green, obj: RCLTrashType.metal)
            slices.append(slice)
        }
        
        if organic > 0
        {
            let slice = PieSliceModel(value: Double(organic), color: UIColor.orange, obj: RCLTrashType.organic)
            slices.append(slice)
        }
        if batteries > 0
        {
            let slice = PieSliceModel(value: Double(batteries), color: UIColor.purple, obj: RCLTrashType.batteries)
            slices.append(slice)
        }
        if glass > 0
        {
            let slice = PieSliceModel(value: Double(glass), color: UIColor.white, obj: RCLTrashType.glass)
            slices.append(slice)
        }
        if paper > 0
        {
            let slice = PieSliceModel(value: Double(paper), color: UIColor.blue, obj: RCLTrashType.paper)
            slices.append(slice)
        }
        return slices
}
    
    //  MARK: - Layers
    
    fileprivate func createCustomViewsLayer() -> PieCustomViewsLayer {
        
        let viewLayer = PieCustomViewsLayer()
        
        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 135
        settings.hideOnOverflow = false
        viewLayer.settings = settings
        
        viewLayer.viewGenerator = createViewGenerator()
        
        return viewLayer
    }
    
    fileprivate func createTextLayer() -> PiePlainTextLayer {
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 75
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 12)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    fileprivate func createViewGenerator() -> (PieSlice, CGPoint) -> UIView {
        return
            
            {
            slice, center in
            print(slice)
            let container = UIView()
            container.frame.size = CGSize(width: 100, height: 40)
            container.center = center
            let view = UIImageView()
            view.frame = CGRect(x: 30, y: 0, width: 40, height: 40)
            container.addSubview(view)
            
            if slice.data.id == 3 || slice.data.id == 0 {
                let specialTextLabel = UILabel()
                specialTextLabel.textAlignment = .center
                if slice.data.id == 0 {
                    specialTextLabel.font = UIFont.boldSystemFont(ofSize: 18)
                } else if slice.data.id == 3 {
                    specialTextLabel.textColor = UIColor.blue
                }
                specialTextLabel.sizeToFit()
                specialTextLabel.frame = CGRect(x: 0, y: 40, width: 100, height: 20)
                container.addSubview(specialTextLabel)
                container.frame.size = CGSize(width: 100, height: 60)
            }
            
                 let imageName: String? = {
                if let temp = slice.data.model.obj {
                    print(temp)
                    switch temp {
                    case RCLTrashType.plastic:
                        return "trash_plastic"
                    case RCLTrashType.glass:
                        return "trash_glass"
                    case RCLTrashType.metal:
                        return "trash_metal"
                    case RCLTrashType.organic:
                        return "trash_organic"
                    case RCLTrashType.paper:
                        return "trash_paper"
                    case RCLTrashType.batteries:
                        return "trash_batteries"
                    default:
                        return nil
                    }
                }
                    return nil
                }()

            view.image = imageName.flatMap{UIImage(named: $0)}
            view.contentMode = .scaleAspectFit

            return container
        }
    }
}


