//
//  ViewController.swift
//  weatherApplication
//
//  Created by dimitris vlagas on 29/8/16.
//  Copyright © 2016 webmate. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var longtitudee :Double?
    var latitudee : Double?
    // from weather model create object kavala that will be changed with current long and lat
    var weather : Weather!
    var city = ""
    
    //all of our outlets
    
    @IBOutlet weak var fifthLowLbl: customLabel!
    @IBOutlet weak var fifthHighLbl: customLabel!
    @IBOutlet weak var fifthDayLbl: customLabel!
    @IBOutlet weak var fifthWeatherImg: UIImageView!
    @IBOutlet weak var fourthLowLbl: customLabel!
    @IBOutlet weak var fourthHighLbl: customLabel!
    @IBOutlet weak var fourthDayLbl: customLabel!
    @IBOutlet weak var fourthWeatherImg: UIImageView!
    @IBOutlet weak var thirdLowLbl: customLabel!
    @IBOutlet weak var thirdHightLbl: customLabel!
    @IBOutlet weak var thirdDayLbl: customLabel!
    @IBOutlet weak var thirdWeatherImg: UIImageView!
    @IBOutlet weak var secondTemperatureLbl: customLabel!
    @IBOutlet weak var secondTimeLbl: customLabel!
    @IBOutlet weak var secondWeatherImg: UIImageView!
    @IBOutlet weak var firstTemperatureLbl: customLabel!
    @IBOutlet weak var firstTimeLbl: customLabel!
    @IBOutlet weak var firstWeatherImg: UIImageView!
    @IBOutlet weak var windLbl: customLabel!
    @IBOutlet weak var temperature: customLabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var timeLbl: customLabel!
    @IBOutlet weak var cityLbl: customLabel!
    @IBOutlet weak var dateLbl: customLabel!
    
    
    
    // geolocation lets and variables
    
    let locationManager = CLLocationManager()
    var longtitud : Double?
    var latitud: Double?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        }
    
    // view did appear
    
    override func viewDidAppear(animated: Bool) {
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            
            
            
        }
    }// end of didviewappear
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
         latitud = locValue.latitude
         longtitud = locValue.longitude
        
        if let longti = longtitud{
            longtitudee  = longti
            
            
        }
        if let landi = latitud {
            latitudee = landi
           
        }
        
        let location = CLLocation(latitude: latitudee!, longitude: longtitudee!) //changed!!!
        print(location)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            //print(location)
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                
                if let cit = pm.locality {
                    self.city = cit
                    //city has now the name of our cordinates
                    
                }
                //print(self.city)
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })// end of ClGeocoder

        weather = Weather(city: city, latitude: latitudee!, longitude: longtitudee!)
        weather.downloadWeather {
            ()->() in
            
        }
        
    }//end locationmanager
    
    

}

