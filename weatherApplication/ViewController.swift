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
    var stopAndStartUpdating = true
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
            
            var timer = NSTimer.scheduledTimerWithTimeInterval( 10, target: self, selector: "updateLoc", userInfo: nil, repeats: false)
           var time = NSTimer.scheduledTimerWithTimeInterval( 3600, target: self, selector: "updateLoc", userInfo: nil, repeats: true)

        }
    }// end of didviewappear
    
    func updateLoc (){
        self.locationManager.startUpdatingLocation()
        stopAndStartUpdating = false
    }
    
    
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
            self.updateUI ()
            self.hourOfTime()
               self.locationManager.stopUpdatingLocation()
            
        }
       

        
    }//end locationmanager
    
    func updateUI () {
        dateLbl.text = weather.date
        timeLbl.text = weather.time
        cityLbl.text = weather.city
        temperature.text = weather.celcious+" ˚C"
        firstTimeLbl.text = weather.firstTime
        firstTemperatureLbl.text = weather.firstCelcius+" ˚C"
        secondTimeLbl.text = weather.secondTime
        secondTemperatureLbl.text = weather.secondCelcius+" ˚C"
        thirdDayLbl.text = weather.thirDay
        thirdLowLbl.text = weather.thirdLowTemp+" ˚C"
        thirdHightLbl.text = weather.thirdHighTemp+" ˚C"
        fourthDayLbl.text = weather.fourthDay
        fourthLowLbl.text = weather.fourthLowTemp+" ˚C"
        fourthHighLbl.text = weather.fourthHighTemp+" ˚C"
        fifthDayLbl.text = weather.fifthDay
        fifthLowLbl.text = weather.fifthLowTemp+" ˚C"
        fifthHighLbl.text = weather.fifthHighTemp+" ˚C"

        
        
        windLbl.text = weather.wind+" m/s"
         mainImg.image = getImg(weather.weatherImg)
        firstWeatherImg.image = getImg(weather.firstWeatherImg)
        secondWeatherImg.image = getImg(weather.secondWeatherImg)
        thirdWeatherImg.image = getImg(weather.thirdWeatherImg)
        fourthWeatherImg.image = getImg(weather.fourthWeatherImg)
        fifthWeatherImg.image = getImg(weather.fifthWeatherImg)
        
        let time = hourOfTime()
        if weather.weatherImg == "clear-day"{
            let temp = UIColor(red: 255/255.0, green: 214/255.0, blue: 108/255.0, alpha: 1.0)
            view.backgroundColor = temp
        }
        if weather.weatherImg == "clear-night"{
            let temp = UIColor(red: 175/255.0, green: 85/255.0, blue: 187/255.0, alpha: 1.0)
            view.backgroundColor = temp
            
        }
        if weather.weatherImg == "rain" && time < 21{
            let temp = UIColor(red: 54/255.0, green: 111/255.0, blue: 144/255.0, alpha: 1.0)
            view.backgroundColor = temp
        }
        if weather.weatherImg == "rain" && time > 21{
           
            let temp = UIColor(red: 69/255.0, green: 18/255.0, blue: 85/255.0, alpha: 1.0)
            view.backgroundColor = temp
        }
        if ((weather.weatherImg  == "cloudy") || (weather.weatherImg == "partly-cloudy-day")){
            let temp = UIColor(red: 90/255.0, green: 198/255.0, blue: 185/255.0, alpha: 1.0)
            view.backgroundColor = temp
                    }
        if (weather.weatherImg == "partly-cloudy-night"){
            let temp = UIColor(red: 115/255.0, green: 59/255.0, blue: 133/255.0, alpha: 1.0)
            view.backgroundColor = temp
        }
       if (weather.weatherImg == "snow"){
            let temp = UIColor(red: 3/255.0, green: 20/255.0, blue: 68/255.0, alpha: 1.0)
            view.backgroundColor = temp
                    }
        
        
    }
    
    
    func getImg(img: String) -> UIImage? {
        let time = hourOfTime()
        if img == "clear-day"{
            return UIImage(named:"sun" )!
        }
        if img == "clear-night"{
            return UIImage(named:"night_sunny")!
            
        }
        if img == "rain" && time < 20{
            return UIImage(named:"rain")!
            
        }
        if img == "rain" && time > 20{
            return UIImage(named: "rain_night")
            
        }
        if ((img == "cloudy") || (img == "partly-cloudy-day")){
            return UIImage(named: "cloudly")
        }
        if (img=="partly-cloudy-night"){
            return UIImage(named: "cloud_night")
        }
          if (img == "snow"){
            return UIImage(named:"snow")!
        }
        return nil
       
    }
    
    
    func hourOfTime() -> Int{
        let date = NSDate()
        let calender = NSCalendar.currentCalendar()
        let components = calender.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        return Int(hour)
    }
    
    
    
    

}

