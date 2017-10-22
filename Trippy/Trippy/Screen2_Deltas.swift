//
//  Screen2_Deltas.swift
//  Trippy
//
//  Created by Lambros Tzanetos on 14/10/17.
//  Copyright © 2017 LamprosTzanetos. All rights reserved.
//

import UIKit

class Screen2_Deltas: UIViewController {

   // @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var visaRequirement: UILabel!
    @IBOutlet var vaccinationRequirement: UILabel!
    @IBOutlet var embassyAddress: UILabel!
    @IBOutlet var travelAdvisoriesReq: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //trippy/destination/info?id={id}
        //let countryID = UserDefaults.standard.object(forKey: "CountryID")
        
        /*
        let urlDeltas = URL(string: "http://192.168.30.243:5000/trippy/destination/deltas?homeid=7c8a38c6-e&destid=03696aea-f")
        
        //let urlDeltas = URL(string: "http://192.168.30.243:5000/trippy/destination?name=test")
        
        let taskDeltas = URLSession.shared.dataTask(with: urlDeltas!) { (data, response, error) in
            if error != nil {
                print ("ERROR")
            }
            else {
                if data != nil {
                    do {
                        
                        let myJson = try? JSONSerialization.jsonObject(with: data!, options: [])
                        if let dictionary = myJson as? [String: Any] {
                            print("BLBLB" + dictionary.description)
                            
                        }
                    }
                    catch {
                        
                    }
                }
            }
        }
        taskDeltas.resume()
        
        */
        
        let urlDeltas = URL(string: "http://192.168.30.243:5000/trippy/destination/travel?homeid=7c8a38c6-e&destid=03696aea-f")
        
        //let urlDeltas = URL(string: "http://192.168.30.243:5000/trippy/destination?name=test")
        
        let taskDeltas = URLSession.shared.dataTask(with: urlDeltas!) { (data, response, error) in
            if error != nil {
                print ("ERROR")
            }
            else {
                if data != nil {
                    do {
                        
                        let myJson = try? JSONSerialization.jsonObject(with: data!, options: [])
                        if let dictionary = myJson as? [String: Any] {
                            print("BLBLBB" + dictionary.description)
                            
                            
                            //print("BLBLB2" + String((dictionary["ExchangeRate"] as! Double)))
                            if let document = dictionary["Documents"] as? Int {
                                var requirement: String = ""
                                if document == 0 {
                                    requirement = "No Travel Documents Needed"
                                } else if document == 1 {
                                    requirement = "Passport Required"
                                } else if document == 2 {
                                    requirement = "Visa Required"
                                }
                                
                                self.visaRequirement.text = "Requirement: " + requirement
                                
                            }
                            
                            self.vaccinationRequirement.text = "No Vaccination Requirements Exist"
                            
                            if let embassyLocation = dictionary["EmbassyAddress"] as? String {
                                self.embassyAddress.text = "Address Of Embassy: " + embassyLocation
                            }
                            
                            self.travelAdvisoriesReq.text = "No Travel Advisories Requirements"
                        }
                    }
                }
            }
        }
        taskDeltas.resume()

        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
