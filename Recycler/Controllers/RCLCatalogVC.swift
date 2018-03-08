//
//  RCLCatalogVC.swift
//  Recycler
//
//  Created by Yurii Tsymbala on 3/8/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLCatalogVC: UIViewController {
    
    let trashLabels = ["Paper","Glass","Metall","Plastic","Organic","Batteries"]
    
    // trash_glass add
    let trashImages : [UIImage] = [
        UIImage (named : "trash_paper")!,
        UIImage (named : "trash_paper")!,
        UIImage (named : "trash_metal")!,
        UIImage (named : "trash_plastic")!,
        UIImage (named : "trash_organic")!,
        UIImage (named : "trash_batteries")!
    ]
    
    @IBOutlet weak var catalogTableView: UITableView!
    
    override func viewDidLoad() {
        catalogTableView.delegate = self
        catalogTableView.dataSource = self
        super.viewDidLoad()
    }
}

extension RCLCatalogVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trashLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = catalogTableView.dequeueReusableCell(withIdentifier: "CatalogCell") as! RCLCatalogTableViewCell
        cell.catalogImageView.image = trashImages[indexPath.row]
        cell.catalogLabel.text = trashLabels[indexPath.row]
        return cell
    }
}

extension RCLCatalogVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
