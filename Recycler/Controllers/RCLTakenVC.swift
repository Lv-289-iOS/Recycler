//
//  RCLTakenVC.swift
//  Recycler
//
//  Created by Ostin Ostwald on 3/13/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLTakenVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userView: UIView!
    

    
    let cellId = "RCLTakenCell"
    let nib = "RCLTakenCell"
    var data = [(Trash,TrashCan,User)]()
    
    @IBAction func logOut(_ sender: UIButton) {
        RCLAuthentificator.signOut()
        let st = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = st.instantiateViewController(withIdentifier: "LoginVC") as? RCLLoginVC else {return}
        self.present(loginVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: nib, bundle: nil ), forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        addTitleLabel(text: "MyTasks")
        userView.layer.cornerRadius = 10
        userView.backgroundColor = UIColor.Backgrounds.GrayLight
        name.text = "User: \(currentUser.firstName) \(currentUser.lastName)"
        FirestoreService.shared.getDataForEmployer(status: .taken) { data in
            self.data = data
            self.tableView.reloadData()
        }
    }
    
  }

extension RCLTakenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RCLTakenCell else {
            return UITableViewCell()
        }
        tableView.rowHeight = UITableViewAutomaticDimension
        cell.selectionStyle = .none
        cell.configureCell(forData: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
