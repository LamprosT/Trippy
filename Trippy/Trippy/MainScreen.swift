//
//  ViewController.swift
//  Trippy
//
//  Created by Lambros Tzanetos on 14/10/17.
//  Copyright © 2017 LamprosTzanetos. All rights reserved.
//

import UIKit
import Foundation

var idCountry: String = "error"

class MainScreen: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    
    @IBOutlet var locationPicker: UIPickerView!
    
    var images = [UIImage]()
    
    var counter = 0
    var imageCounter = 0
    let minAlpha: CGFloat = 0
    let maxAlpha: CGFloat = 1
    
    var timer = Timer()
    
    
    var locationPickerDataSource = ["Bulgaria", "Greece", "UK", "France", "Germany", "Switzerland", "Czech Republic", "Spain"] //add countries
    var selectedLocation : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "sunset-over-oia-Santorini-Greece-conde-nast-traveller-11aug17-iStock_810x540.jpg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        // Do any additional setup after loading the view, typically from a nib.
        selectedLocation = locationPickerDataSource[0]
        
        self.locationPicker.dataSource = self
        self.locationPicker.delegate = self
        locationPicker.isHidden = true
        
        images = [UIImage(named:"bigBen.jpg")!, UIImage(named:"Burj.jpg")!, UIImage(named:"eiffel.jpeg")!, UIImage(named:"mayaTemple.jpg")!, UIImage(named:"liberty.jpeg")!, UIImage(named:"parthenon.jpg")!, UIImage(named:"pisaTower.jpg")!]
        
        imageView.image = images[0]
        imageView.alpha = self.maxAlpha
        
        beginTimer()
        
    }
    
    func beginTimer() {
      //  timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: processTime())
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainScreen.processTime), userInfo: nil, repeats: true)
    }
    
    func processTime(){
        
       // imageView.image = UIImage(named: "frame_\(counter)_delay-0.04s.gif")
        counter += 1
        
        if counter == 3 {
            if imageCounter == 6 {
                imageCounter = 0
            } else {
                imageCounter += 1
            }
            
            timer.invalidate()
            counter = 0
            fade()
            
        }
    
    }
    
    func fade() {
        imageView2.image = imageView.image
        imageView.alpha = minAlpha
        
        imageView.image = images[imageCounter]
        
        UIView.animate(withDuration: 2, animations: {
            self.imageView.alpha = self.maxAlpha
        })
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainScreen.processTime), userInfo: nil, repeats: true)
       
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view != locationPicker {
                locationPicker.isHidden = true
                
            }
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //return 2 if deciding to add cities
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       //number of rows in picker
        return locationPickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationPickerDataSource[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLocation = locationPickerDataSource[row]
        print("THIS IS THE LOCATION:" + selectedLocation)
    }
    
    @IBAction func selectLocationAction(_ sender: Any) {
        locationPicker.isHidden = false
    }
    
    @IBAction func execute(_ sender: Any) {
        
        let idURL = URL(string: "http://192.168.30.243:5000/trippy/destination?name=\(selectedLocation)")
        //var id = "error"
        let idTask = URLSession.shared.dataTask(with: idURL!) { (data, response, error) in
            if error != nil {
                print ("ERROR")
            }
            else {
                if data != nil {
                    do {
                        print("HAHAHAHA")
                        print("f! " + self.selectedLocation)
                        let myJson = try? JSONSerialization.jsonObject(with: data!, options: [])
                        
                        print(myJson!)
                        
                        if let dictionary = myJson as? [String: Any] {
                            idCountry = dictionary["Id"]! as! String
                            print("DOES IT CHANGE???" + idCountry)
                            UserDefaults.standard.set(idCountry, forKey: "CountryID")
                        }
                    }
                    
                }
            }
        }
        
        //UserDefaults.standard.set(idCountry, forKey: "CountryID")
        
        idTask.resume()
        
      //  print("DOES IT CHANGE2???" + idCountry)
        UserDefaults.standard.set(self.selectedLocation, forKey: "CountryID")
        performSegue(withIdentifier: "goToPages", sender: self)

        
    }
    
}

