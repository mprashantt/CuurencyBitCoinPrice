//
//  ViewController.swift
//  BitCoin Price
//
//  Created by Prashant Tripathi on 25/06/19.
//  Copyright © 2019 Prashant Tripathi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray =  ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbolsArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    var currentSymbol = ""
    
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        currentSymbol = currencySymbolsArray[row]
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitcoinPriceForSelectedCurrency(url: finalURL)
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getBitcoinPriceForSelectedCurrency(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got Bitcoin Price for selected currency")
                    let bitcoinPriceJSON : JSON = JSON(response.result.value!)
                    
                    self.updateBitcoinPrice(json: bitcoinPriceJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.priceLabel.text = "Connection Issues"
                }
        }
    }
    
    
    // MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitcoinPrice(json : JSON) {
        
        if let bitcoinPrice = json["last"].double  {
            
            
            priceLabel.text = "\(currentSymbol) \(bitcoinPrice)"
        }
            
        else {
            priceLabel.text = "Price Unavailable"
        }
    }
    
}

