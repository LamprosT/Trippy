//
//  Screen1_Basic.swift
//  Trippy
//
//  Created by Lambros Tzanetos on 14/10/17.
//  Copyright © 2017 LamprosTzanetos. All rights reserved.
//

import UIKit
import Foundation


class Screen1_Basic: UIViewController {
   

    //@IBOutlet var scrollView: UIScrollView!
   
    
    //Essentials
    @IBOutlet var officialLanguage: UILabel!
    @IBOutlet var secondLanguage: UILabel!
    @IBOutlet var currency: UILabel!
    
    //Emergency Numbers
    @IBOutlet var police: UILabel!
    @IBOutlet var ambulance: UILabel!
    @IBOutlet var fire: UILabel!
    
    //Measurements
    @IBOutlet var measurementSystem: UILabel!
    
    //Telecom Information
    @IBOutlet var dialingCode: UILabel!
    @IBOutlet var localCompanies: UILabel!
    
    //Drug and Alcohol Laws
    @IBOutlet var drugLaws: UILabel!
    @IBOutlet var alcoholLaws: UILabel!
    
    //Car Travel
    @IBOutlet var drivingLicense: UILabel!
    @IBOutlet var drivingSide: UILabel!
    
    //Tipping
    @IBOutlet var tips: UILabel!
    
    //Crime Rate
    @IBOutlet var crimeRate: UILabel!
    
    //Country Deltas
    @IBOutlet var currencyExchangeRate: UILabel!
    @IBOutlet var averageCostOfGas: UILabel!
    @IBOutlet var averageCostOfMeal: UILabel!
    @IBOutlet var powerSockets: UILabel!
    @IBOutlet var powerVoltage: UILabel!
    @IBOutlet var averageTemperatureDiff: UILabel!
    @IBOutlet var averagePercipitationDiff: UILabel!
    @IBOutlet var hemisphere: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //scrollView.contentSize = scrollView.contentSize
        var countryCode = ""
        if let countryID = UserDefaults.standard.object(forKey: "CountryID") as? String {
            print("CHECK: " + countryID)
            if countryID == "Greece" {
                countryCode = "7c8a38c6-e"
            } else {
                print("GAMOSPITE")
                countryCode = "03696aea-f"
            }
            
        }
        
        
       // let url = URL(string: "http://192.168.30.243:5000/trippy/destination/info?id=8e25ddd1-5")
        let url = URL(string: "http://192.168.30.243:5000/trippy/destination/info?id=\(countryCode)")

        
       
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print ("ERROR")
            }
            else {
                if data != nil {
                    do {
                        //Array
                        let myJson = try? JSONSerialization.jsonObject(with: data!, options: [])
                        if let dictionary = myJson as? [String: Any] {
                            
                            print("WE IN")
                            print(dictionary.description)
                            
                            //Assign Essentials
                            if let officialLanguageObj = dictionary["OfficialLanguage"] as? [String: Any] {
                                //let id = officialLanguageObj["Id"] as? String
                                let languageSpoken = officialLanguageObj["Name"] as! String
                                self.officialLanguage.text = "Official Language: \(languageSpoken)"
                            }
                            
                            if let secondLanguages = dictionary["WidelySpokenLanguages"] as? [[String: Any]] {
                                secondLanguages.forEach { language in
                                    self.secondLanguage.text = self.secondLanguage.text! + (language["Name"] as! String) + ", "
                                }
                            }
                            
                            if let currencyValue = dictionary["Currency"] as? String {
                                self.currency.text = "Currency: " + currencyValue
                            }
                            
                            //Emergency Numbers
                            if let emergencyNumbers = dictionary["EmergencyNumbers"] as? [[String: Any]] {
                                emergencyNumbers.forEach { numbers in
                                    
                                    if let numberID = numbers["Id"] as? Int {
                                        
                                        //if var callNum = numbers["Number"] as? Int {
                                        print("NUMBERSSS")
                                        let callNum = numbers["Number"] as! String
                                        if numberID == 1 {
                                            self.police.text = "Police: \(callNum)"
                                        } else if numberID == 2 {
                                            self.ambulance.text = "Ambulance: \(callNum)"
                                        } else if numberID == 3 {
                                            self.fire.text = "Fire: \(callNum)"
                                        }
                                        
                                    }
                                }
                                
                                //TODO: ADD THEM
                            }
                            
                            //Measurements
                            if let mesSystem = dictionary["DoesntUseMetricSystem"] as? Bool {
                                if mesSystem {
                                    self.measurementSystem.text = "Measurement System: Imperial"
                                } else {
                                    self.measurementSystem.text = "Measurement System: Metric"
                                }
                            }
                            
                            //Telecom Info
                            if let dialCode = dictionary["DialCode"] as? String {
                                self.dialingCode.text = "Dialing Code: " + dialCode
                            }
                            
                            if let telecomCompanies = dictionary["Telecoms"] as? String {
                                self.localCompanies.text = "Local Telecom Companies: " + telecomCompanies
                            }
                            
                            //Drugs and Alcohol Laws
                            if let alcLaw = dictionary["DrinkingAge"] as? Int {
                                if alcLaw == 0 {
                                    self.alcoholLaws.text = "Alcohol Laws: Illegal"
                                } else {
                                    self.alcoholLaws.text = "Alcohol Laws: \(alcLaw)+"
                                }
                            }
                            
                            //TODO: ADD DRUG LAWS
                            self.drugLaws.text = "Drug Laws: Illegal"
                            
                            
                            //Car Travel
                            if let license = dictionary["DriverLicense"] as? Int {
                                if license == 0 {
                                    self.drivingLicense.text = "Driving License: Local License"
                                } else if license == 1 {
                                    self.drivingLicense.text = "Driving License: EU License"
                                } else {
                                    self.drivingLicense.text = "Driving License: International License"
                                }
                            }
                            if let sideOfRoad = dictionary["WrongSideOfRoad"] as? Bool {
                                if sideOfRoad {
                                    self.drivingSide.text = "Driving Side: Left"
                                } else {
                                    self.drivingSide.text = "Driving Side: Right"
                                }
                            }
                            
                            //Tipping
                            if let tipping = dictionary["Tipping"] as? Int {
                                switch tipping {
                                case 0:
                                    self.tips.text = "Tips: None"
                                    break;
                                
                                case 1:
                                    self.tips.text = "Tips: Optional"
                                    break;
                                    
                                case 2:
                                    self.tips.text = "Tips: Recommended"
                                    break;
                                
                                case 3:
                                    self.tips.text = "Tips: Required"
                                    break;
                                    
                                default:
                                    break;
                                }
                            }
                            
                            //Crime Rate
                            //TODO: ADD CRIME RATE
                            self.crimeRate.text = "Crime Rate: 12%"
                            
                            
                            //Country Deltas
                            
                            if let powerSocketsType = dictionary["PowerSocket"] as? String {
                                self.powerSockets.text = "Power Sockets: \(powerSocketsType)"
                            }
                            
                            if let powerVoltageIndicator = dictionary["PowerGridVoltage"] as? Int {
                                self.powerVoltage.text = "Power Voltage: \(powerVoltageIndicator)"
                            }
                            
                            if let hemisphereIndicator = dictionary["IsNorthHemisphere"] as? Bool {
                                if hemisphereIndicator {
                                    self.hemisphere.text = "Hemisphere: North"
                                } else {
                                    self.hemisphere.text = "Hemisphere: South"
                                }
                            }

                            //TODO: ADD ACTUAL INDICATORS FOR WEATHER AND FOOD
                            self.averagePercipitationDiff.text = "Avg. Temperature Difference: +2%"
                            
                            self.averageTemperatureDiff.text = "Avg. Percipitation Difference: -6%"
                            
                            self.averageCostOfGas.text = "Avg. Cost of Gas: 1.58"
                            
                            self.averageCostOfMeal.text = "Avg. Cost of Meal: 8"
                            
                            
    
                        }
                    }
                   
                }
            }
        }
        task.resume()
        
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
                            if let exchangeRate = dictionary["ExchangeRate"] as? Double {
                                self.currencyExchangeRate.text = "Currency Exchange Rate: " + String(exchangeRate)
                                
                            }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
