//
//  ViewController.swift
//  weatherApp
//

import UIKit

class ViewController: UIViewController {
    
    var weatherData = WeatherData()
    
    //今天
    @IBOutlet var city: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var temp_max: UILabel!
    @IBOutlet var temp_min: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var sunrise: UILabel!
    @IBOutlet var sunset: UILabel!
    //@IBOutlet var webViewBG: UIWebView!
    
    //預測
    @IBOutlet var day1: UILabel!
    @IBOutlet var day2: UILabel!
    @IBOutlet var day3: UILabel!
    @IBOutlet var temp1: UILabel!
    @IBOutlet var temp2: UILabel!
    @IBOutlet var temp3: UILabel!
    
    var cityID = Int32(1668341) //Taipei ID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //動態背景
        //let filePath = Bundle.main.path(forResource: "rainy", ofType: "gif")
        //webViewBG.loadRequest(URLRequest(url: URL(string: filePath!)!))
        //webViewBG.isUserInteractionEnabled = false
        
        setCurrentWeather()
        setForeCastWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCurrentWeather()
        setForeCastWeather()
    }
    
    //載入現在天氣
    func setCurrentWeather(){
        var json = weatherData.currentDataJSON(id: cityID)
        var main = json["main"] as! [String:Any]
        var sys = json["sys"] as! [String:Any]
        city.text = json["name"] as? String
        temperature.text = "\(convertDegree(main["temp"]!))°"
        temp_max.text = "\(convertDegree(main["temp_max"]!))°"
        temp_min.text = "\(convertDegree(main["temp_min"]!))°"
        pressure.text = "\(main["pressure"]!) hpa"
        humidity.text = "\(main["humidity"]!) %"
        let srise = Date(timeIntervalSince1970: (sys["sunrise"] as? Double)!)
        let sset = Date(timeIntervalSince1970: (sys["sunset"] as? Double)!)
        let dateformat = DateFormatter()
        dateformat.timeStyle = DateFormatter.Style.short
        sunrise.text = "\(dateformat.string(from: srise))"
        sunset.text = "\(dateformat.string(from: sset))"
    }
    
    //載入未來天氣，只使用三天的預測值
    func setForeCastWeather(){
        var forejson = weatherData.forcastDataJSON(id: cityID)
        var list = forejson["list"] as! [[String:Any]]
        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH"
        
        let date1 = Date(timeIntervalSince1970: (list[0]["dt"] as? Double)!)
        let date2 = Date(timeIntervalSince1970: (list[1]["dt"] as? Double)!)
        let date3 = Date(timeIntervalSince1970: (list[2]["dt"] as? Double)!)
        let fore1 = list[0]["main"] as! [String:Any]
        let fore2 = list[1]["main"] as! [String:Any]
        let fore3 = list[2]["main"] as! [String:Any]
        
        day1.text = "\(dateformat.string(from: date1))時"
        day2.text = "\(dateformat.string(from: date2))時"
        day3.text = "\(dateformat.string(from: date3))時"
        
        temp1.text = "\(convertDegree(fore1["temp"]!))°"
        temp2.text = "\(convertDegree(fore2["temp"]!))°"
        temp3.text = "\(convertDegree(fore3["temp"]!))°"
        
    }
    
    //轉換絕對溫度
    func convertDegree(_ degree: Any) -> Double{
        return (degree as! Double) - 273.15
    }
    
    //選擇天氣圖片
    func weatherPic(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

