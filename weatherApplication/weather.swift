//
//  weather.swift
//  weatherApplication
//
//  Created by dimitris vlagas on 31/8/16.
//  Copyright © 2016 webmate. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    // all the data we want in variables
    
    private var _latitude:Double!
    private var _longitude: Double!
    private var _date : String!
    private var _city : String!
    private var _time : String!
    private var _weatherImg : String!
    private var _celcius : String!
    private var _wind : String!
    
    private var _firstWeatherImg : String!
    private var _firstTime : String!
    private var _firstCelcius : String!
    
    private var _secondWeatherImg :String!
    private var _secondTime : String!
    private var _secondCelcius : String!
    
    private var _thirdWeatherImg : String!
    private var _thirdDay : String!
    private var _thirdHighTemp : String!
    private var _thirdLowTemp : String!
    
    private var _fourthWeatherImg : String!
    private var _fourthDay : String!
    private var _fourthHighTemp : String!
    private var _fourthLowTemp : String!
    
    private var _fifthWeatherImg : String!
    private var _fifthDay : String!
    private var _fifthHighTemp : String!
    private var _fifthLowTemp : String!
    
    
    // we use as property weather for init the city name
    var city : String {
        return _city
    }
    var latitude : Double {
        return _latitude
    }
    var longitude : Double {
        return _longitude
    }
    
    init (city : String, latitude: Double , longitude: Double ){
        self._city = city
        self._latitude = latitude
        self._longitude = longitude
        
       
        
    }
    
    func set_current_date() {
        var monthText = ""
        var dayText = ""
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        
        let month = components.month
        let day = components.day
        
        if month == 1 {
            monthText = "Jan"
        }else if month == 2{
            monthText = "Feb"
        }else if month == 3 {
            monthText = "Mar"
        }else if month == 4{
            monthText = "Apr"
        }else if month == 5{
            monthText = "May"
        }else if month == 6{
            monthText = "Jun"
        }else if month == 7 {
            monthText = "Jul"
        }else if month == 8 {
            monthText = "Aug"
        }else if month == 9 {
            monthText = "Sep"
        }else if month == 10 {
            monthText = "Oct"
        }else if month == 11{
            monthText = "Nov"
        }
        else{
            monthText = "Dec"
        }
        dayText = String(day)
        
        self._date = dayText+" "+monthText
      
    }
    func set_current_Time(){
      
        let date = NSDate()
        let calender = NSCalendar.currentCalendar()
        let components = calender.components([.Hour, .Minute], fromDate: date)
        let hour = String(components.hour)
        let minute = String(components.minute)
        let firstHour = components.hour + 4
        let secondHour = components.hour + 12
        self._time = hour+":"+minute
        self._firstTime = String(firstHour)+":00"
        self._secondTime = String(secondHour)+":00"
        
    }
    
    
    //downloading from api
    
    func downloadWeather(completed : DownloadComplete)   {
        set_current_date()
        set_current_Time()
        let latt = String(latitude)
        let longg = String(longitude)
        let weatherUrl = URL_BASE+API_KEY+latt+","+longg
        let url = NSURL(string: weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            // test if api is downloaded print(result.value.debugDescription)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let currently =  dict["currently"] as? Dictionary<String, AnyObject> {
                    if let icon = currently["icon"] as? String{
                        self._weatherImg = icon
                    }
                    if let windSpeed = currently["windSpeed"] as? Int{
                        self._wind = String(windSpeed)
                    }
                    if let temperature = currently["temperature"] as? Int{
                        self._celcius = String(temperature)
                    }
                    
                    
                    
                    
                }//end currently
                if let hourly = dict["hourly"] as? Dictionary<String, AnyObject> {
                    if let data = hourly["data"] as? [Dictionary<String, AnyObject>]{
                        if let icon = data[4]["icon"] as? String {
                            self._firstWeatherImg = icon
                        }
                        if let icon = data[12]["icon"] as? String {
                            self._secondWeatherImg = icon
                            
                        }
                        if let temperature = data[4]["temperature"] as? Int{
                            self._firstCelcius = String(temperature)
                        }
                        if let temperature = data[12]["temperature"] as? Int{
                            self._secondTime = String(temperature)
                        }

                    }
                    
                }//end hourly
                if let daily = dict["daily"] as? Dictionary<String, AnyObject> {
                    if let data = daily["data"] as? [Dictionary<String,AnyObject>]{
                        if let icon = data[0]["icon"] as? String{
                            self._thirdWeatherImg = icon
                        }
                        if let tempmin = data[0]["temperatureMin"] as? Int {
                            self._thirdLowTemp = String(tempmin)
                        }
                        
                    }
                    
                    
                }//end daily
              
                
            }//end dictionary
            
            
        }//end downloadweather func
       
        
        
        
    }
    
    
    
}
