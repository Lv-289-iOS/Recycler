//
//  RCLCustomAlert.swift
//  Recycler
//
//  Created by Ganna Melnyk on 3/12/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLCustomAlert: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var alertText: UILabel!
    @IBAction func dismissButton(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setText(text: String) {
        alertText.text = text
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "RCLCustomAlert", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
