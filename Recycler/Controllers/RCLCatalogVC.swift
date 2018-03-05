//
//  RCLCatalogVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 02.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLCatalogVC: UIViewController {
    
    let trashImages = ["Paper","Glass","Metall","Plastic","Organic","Batteries"]
    
    let trashLabels = ["Paper","Glass","Metall","Plastic","Organic","Batteries"]
    
    
    @IBOutlet weak var catalogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogTableView.delegate = self
        catalogTableView.dataSource = self
        
    }
    
}

extension RCLCatalogVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return trashLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = catalogTableView.dequeueReusableCell(withIdentifier: "CatalogCell") as! RCLCatalogTableViewCell
        cell.catalogLabel.text = trashLabels[indexPath.row]
        
        return cell
    }
}

extension RCLCatalogVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


