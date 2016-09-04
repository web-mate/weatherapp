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
    
    var time: String{
        if _time == nil{
            _time = ""
        }
        return _time
    }
    var date: String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    var city : String {
        if _city == nil{
            _city = ""
        }
        return _city
    }
    var latitude : Double {
        return _latitude
    }
    var longitude : Double {
        return _longitude
    }
    var weatherImg : String {
        if _weatherImg == nil{
            _weatherImg = ""
        }
        return _weatherImg
    }
    var celcious : String {
        if _celcius == nil{
            _celcius = ""
        }
        return  _celcius
    }
    var wind : String{
        if _wind == nil{
            _wind = ""
        }
        return  _wind
    }
    var firstWeatherImg: String{
        if _firstWeatherImg == nil{
            _firstWeatherImg = ""
        }
        return _firstWeatherImg
    }
    var firstTime: String{
        if _firstTime == nil {
            _firstTime = ""
        }
        return _firstTime
    }
    var firstCelcius: String {
        if _firstCelcius == nil{
            _firstCelcius = ""
        }
        
        return _firstCelcius
    }
    var secondWeatherImg : String {
        if _secondWeatherImg == nil{
            _secondWeatherImg = ""
        }
        return _secondWeatherImg
    }
    var secondTime : String {
        if _secondTime == nil{
            _secondTime = ""
        }
        return _secondTime
    }
    var secondCelcius : String{
        if _secondCelcius == nil{
            _secondCelcius = ""
        }
        return _secondCelcius
    }
    var thirdWeatherImg: String{
        if _thirdWeatherImg == nil{
            _thirdWeatherImg = ""
        }
        return _thirdWeatherImg
    }
    var thirDay: String{
        if _thirdDay == nil{
            _thirdDay = ""
        }
        return _thirdDay
    }
    var thirdHighTemp: String{
        if _thirdHighTemp == nil {
            _thirdHighTemp = ""
        }
        return _thirdHighTemp
    }
    var  thirdLowTemp : String{
        if _thirdLowTemp == nil{
            _thirdLowTemp = ""
        }
     return _thirdLowTemp
    }
    var fourthWeatherImg: String{
        if _fourthWeatherImg == nil {
            _fourthWeatherImg = ""
        }
        return _fourthWeatherImg
    }
    var fourthDay: String{
        if _fourthDay == nil{
            _fourthDay = ""
        }
        return _fourthDay
    }
    var fourthHighTemp: String{
        if _fourthHighTemp == nil{
            _fourthHighTemp = ""
        }
        return _fourthHighTemp
    }
    var fourthLowTemp :String{
        if _fourthLowTemp == nil{
            _fourthLowTemp = ""
        }
        return _fourthLowTemp
    }
    var fifthWeatherImg:String{
        if _fifthWeatherImg == nil {
            _fifthWeatherImg = ""
        }
        return _fifthWeatherImg
    }
    var fifthDay : String{
        if _fifthDay == nil{
            _fifthDay = ""
        }
        return _fifthDay
    }
    var fifthHighTemp : String{
        if _fifthHighTemp == nil{
            _fifthHighTemp = ""
        }
        return _fifthDay
    }
    var fifthLowTemp: String{
        if _fifthLowTemp == nil {
            _fifthLowTemp = ""
        }
        return _fifthLowTemp
    }
    
    
    
    init (city : String, latitude: Double , longitude: Double ){
        self._city = city
        self._latitude = latitude
        self._longitude = longitude
        
    }
    
    
    //get the day of week
    func getDayOfWeekString(today:String)->Int? {
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
                            return weekDay
            }
         else {
            return nil
        }
    }
    
    
    //get the name of the day
    func getDayName(day:Int) -> String? {
        if day == 1{
            return "Sunday"
        }else if day == 2{
            return "Monday"
        }else if day == 3 {
            return "Tuesday"
        }else if day == 4 {
            return "Wednesday"
        }else if day == 5 {
            return "Thursday"
        }else if day == 6 {
            return "Friday"
        }else if day == 7{
            return "Saturday"
        }else {
            return nil
        }
        
    }
    
    //get current date and next days
    func set_current_date() {
        var monthText = ""
        var dayText = ""
        let thirDay:Int
        let fourDay:Int
        let fifth:Int
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let allYear = String(year)
        let allMonth = String(month)
        let allDay = String(day)
        let allTimeText = allYear+"-"+allMonth+"-"+allDay
       getDayOfWeekString(allTimeText)
       thirDay = day + 1
       fourDay = day + 2
       fifth = day + 3
        if let third = getDayName(thirDay){
         self._thirdDay = third
        }
        if let four = getDayName(fourDay){
            self._fourthDay = four
        }
        if let fift = getDayName(fifth){
            self._fifthDay = fift
        }
      
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
    
    //get current time
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
                        //first day
                        if let icon = data[1]["icon"] as? String{
                            self._thirdWeatherImg = icon
                        }
                        if let tempmin = data[1]["temperatureMin"] as? Int {
                            self._thirdLowTemp = String(tempmin)
                        }
                        if let tempHigh = data[1]["temperatureMax"] as? Int {
                            self._thirdHighTemp = String(tempHigh)
                        }
                        //second day
                        if let icon = data[2]["icon"] as? String{
                            self._fourthWeatherImg = icon
                        }
                        if let tempmin = data[2]["temperatureMin"] as? Int {
                            self._fourthLowTemp = String(tempmin)
                        }
                        if let tempHigh = data[2]["temperatureMax"] as? Int {
                            self._fourthHighTemp = String(tempHigh)
                        }
                        //third day
                        if let icon = data[3]["icon"] as? String{
                            self._fifthWeatherImg = icon
                        }
                        if let tempmin = data[3]["temperatureMin"] as? Int {
                            self._fifthLowTemp = String(tempmin)
                        }
                        if let tempHigh = data[3]["temperatureMax"] as? Int {
                            self._fifthHighTemp = String(tempHigh)
                        }
                        
                        
                        
                    }
                    
                    
                }//end daily
              
                
            }//end dictionary
            
            completed()
        }//end  alamofire func
       
        
        
        
    }//end downloadweahter fuc
    
    
    
}
