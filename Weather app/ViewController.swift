//
//  ViewController.swift
//  Weather app
//
//  Created by Jakub Sukiennim on 08/06/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var weather: UILabel!
    
    @IBAction func show(_ sender: Any) {
        
        let url = URL(string: "https://www.weather-forecast.com/locations/"+city.text!+"/forecasts/latest")
        var urlError = false
        var weath = ""
        if url != nil {
            
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if error == nil
                {
                    var urlcontetn = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as NSString?
                  
                    
                    var urlarray = urlcontetn?.components(separatedBy: "<span class=\"phrase\">")
                    
                    if urlarray!.count > 0
                    {
                        var weatherarray = urlarray![1].components(separatedBy: "</span")
                         weath = weatherarray[0] as String
                        
                    }
                    else{
                        urlError = true
                    }
                    
                }else{
                    urlError = true
                }
                
                if urlError == true
                {
                    self.showError()
                }else
                {
                    self.weather.text = weath                 }
                
            }
            task.resume()
        }else {
            
            showError()
        }
        
    }
    func showError()
    {
        weather.text = "Brak możliwości znalezienia pogody dla " + city.text! + "Try again"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
            
            
        }
}




