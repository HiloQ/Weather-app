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
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q="+city.text!.replacingOccurrences(of: " ", with: "%20")+",&appid=53732d2f89c7d2f43d499387c741d12b")
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    
                    print(error!)
                    
                    
                }else
                {
                    if let urlContent = data
                    {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent) as AnyObject
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] {
                                DispatchQueue.main.sync {
                                    self.weather.text = String(describing: description)
                                }
                            }
                            
                        } catch {
                            
                            self.weather.text = "A JSON deserialization error occurred: \(error)"
                        }
                        
                    }
                }
                
                
                
            }
            
            task.resume()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
}
