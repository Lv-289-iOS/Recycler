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
    @IBOutlet weak var tableView: UITableView!

    let cellId = "RCLIssuesCell"
    let nib = "RCLIssuesCell"
    var data = [(Trash,TrashCan,User)]()
    var arrIndex: Int?
    var user = currentUser
    
    var blurEffect: UIBlurEffect!
    var blurView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        blurView.center = view.center
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: nib, bundle: nil ), forCellReuseIdentifier: cellId)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        FirestoreService.shared.getDataForEmployer(status: .available) { data in
            self.data = data
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        popUp.layer.cornerRadius = 5
        addTitleLabel(text: "Issues")
        self.tableView.reloadData()
    }
    
    func animateIn() {
        view.addSubview(blurView)
        self.view.addSubview(popUp)
        popUp.center = self.view.center
        popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUp.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.popUp.alpha = 1
            self.popUp.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(){
        self.blurView.removeFromSuperview()
        UIView.animate(withDuration: 0.3, animations: {
            self.popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUp.alpha = 0
        }) { (success) in
            self.popUp.removeFromSuperview()
        }
    }
    
    
    @IBAction func assignToMe(_ sender: UIButton) {
        let tuple = data.remove(at: arrIndex!)
        var trash = tuple.0
        trash.status = RCLTrashStatus.taken.rawValue
        trash.userIdReportedEmpty = user.id
        FirestoreService.shared.update(for: trash, in: .trash)
        tableView.reloadData()
        animateOut()
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
        return  data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RCLIssuesCell else {
            return UITableViewCell()
        }
        tableView.rowHeight = 93
        cell.backgroundColor = UIColor.Backgrounds.GrayLight
        cell.selectionStyle = .none
        cell.configureCell(forData: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateIn()
        arrIndex = indexPath.row
    }
}
