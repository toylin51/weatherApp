//
//  WeatherData.swift
//  weatherApp
//

import Foundation

class WeatherData{
    final private let appId = ""  //輸入API key
    final private let queryID = "id="
    final private let queryKey = "&appid="
    final private let currentWeatherAPI = "http://api.openweathermap.org/data/2.5/weather?" //現在天氣
    final private let forecastWeatherAPI = "http://api.openweathermap.org/data/2.5/forecast?" //未來天氣
    fileprivate var currentWeatherJson = [String:Any]()
    fileprivate var forecastWeatherJson = [String:Any]()
    
    init(){}
    
    func currentDataJSON(id: Int32) -> [String:Any]{
        let url = URL(string: currentWeatherAPI+queryID+String(id)+queryKey+appId)
        do{
            let jsonData = try Data(contentsOf: url!)
            currentWeatherJson = try JSONSerialization.jsonObject(with: jsonData , options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
        }catch{
            print(error)
        }
        return currentWeatherJson
    }
    
    func forcastDataJSON(id: Int32) -> [String:Any]{
        let url = URL(string: forecastWeatherAPI+queryID+String(id)+queryKey+appId)
        do{
            let jsonData = try Data(contentsOf: url!)
            forecastWeatherJson = try JSONSerialization.jsonObject(with: jsonData , options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
        }catch{
            print(error)
        }
        return forecastWeatherJson
    }
}
