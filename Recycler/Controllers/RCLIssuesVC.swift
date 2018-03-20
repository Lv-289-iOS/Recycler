//
//  RCLIssuesVC.swift
//  Recycler
//
//  Created by Roman Shveda on 3/14/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLIssuesVC: UIViewController {

    @IBOutlet var popUp: UIView!
    @IBOutlet weak var visualEfect: UIVisualEffectView!
    var effect: UIVisualEffect!

    @IBOutlet weak var tableView: UITableView!
    let cellId = "RCLIssuesCell"
    let nib = "RCLIssuesCell"
    var trashList = [Trash]()
    var trashCanList = [TrashCan]()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = visualEfect.effect
        visualEfect.effect = nil
        FirestoreService.shared.getDataForEmployer(status: .available) { (trashList, trashCanList, users) in
            self.trashList = trashList
            self.trashCanList = trashCanList
            self.users = users
            self.tableView.reloadData()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: nib, bundle: nil ), forCellReuseIdentifier: cellId)
         addTitleLabel(text: "Issues")
    }
    
    func animateIn() {
        self.view.addSubview(popUp)
        popUp.center = self.view.center
        popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUp.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEfect.effect = self.effect
            self.popUp.alpha = 1
            self.popUp.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUp.alpha = 0
            self.visualEfect.effect = nil
        }) { (success) in
            self.popUp.removeFromSuperview()
        }
    }
    
    
    @IBAction func assignToMe(_ sender: UIButton) {
        
    }
    
    @IBAction func dissmiss(_ sender: UIButton) {
        animateOut()
    }
    
    private func viewSetup() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
}

extension RCLIssuesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  trashList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RCLIssuesCell else {
            return UITableViewCell()
        }
        tableView.rowHeight = 93
        cell.backgroundColor = UIColor.Backgrounds.GrayLight
        cell.selectionStyle = .none
        cell.configureCell(forCan: trashCanList[indexPath.row], forTrash: trashList[indexPath.row], forUser: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RCLIssuesCell
        animateIn()
        
    }
}
