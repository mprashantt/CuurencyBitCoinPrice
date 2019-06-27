//
//  ViewController.swift
//  BitCoin Price
//
//  Created by Prashant Tripathi on 25/06/19.
//  Copyright © 2019 Prashant Tripathi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let countryPickerData = ""
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var priceLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

