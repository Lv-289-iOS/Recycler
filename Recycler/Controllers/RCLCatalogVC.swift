//
//  RCLCatalogVC.swift
//  Recycler
//
//  Created by Yurii Tsymbala on 3/8/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLCatalogVC: UIViewController {
    
    var trashImage: UIImage!
    var trashLabel: String!
    
    let trashLabels = ["paper","glass","metal","plastic","organic","batteries"]
    
    let trashImages : [UIImage] = [
        UIImage (named : "trash_paper")!,
        UIImage (named : "trash_glass")!,
        UIImage (named : "trash_metal")!,
        UIImage (named : "trash_plastic")!,
        UIImage (named : "trash_organic")!,
        UIImage (named : "trash_batteries")!
    ]
    
    @IBOutlet weak var catalogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogTableView.delegate = self
        catalogTableView.dataSource = self
        viewSetup()
    }
    
    private func viewSetup() {
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        catalogTableView.backgroundColor = UIColor.Backgrounds.GrayDark
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTrashPopUpSegue" {
            let trashImageFromCatalog = segue.destination as! RCLAddTrashVC
            trashImageFromCatalog.trashImageFromCatalogVC = trashImage
            let trashLabelFromCatalog = segue.destination as! RCLAddTrashVC
            trashLabelFromCatalog.trashLabelFromCatalogVC = trashLabel
        }
    }
}

extension RCLCatalogVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trashLabels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = catalogTableView.dequeueReusableCell(withIdentifier: "CatalogCell") as! RCLCatalogTableViewCell
        cell.catalogImageView.image = trashImages[indexPath.row]
        cell.catalogLabel.text = trashLabels[indexPath.row]
        
        // Design of CardCell
        // Using closure
        cell.backgroundColor = UIColor.Backgrounds.GrayDark
        cell.catalogView.backgroundColor = UIColor.Backgrounds.GrayLight
        cell.catalogView.layer.cornerRadius = CGFloat.Design.CornerRadius
        cell.catalogImageView.layer.cornerRadius = CGFloat.Design.CornerRadius
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
        return cell
    }
}

extension RCLCatalogVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trashImage = trashImages[indexPath.row]
        trashLabel = trashLabels[indexPath.row]
        performSegue(withIdentifier: "AddTrashPopUpSegue", sender: self)
    }
}
