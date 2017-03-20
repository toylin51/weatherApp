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
    @IBOutlet var currentStatus: UIImageView!
    @IBOutlet var describeStaus: UILabel!
    
    //預測
    @IBOutlet var day1: UILabel!
    @IBOutlet var day2: UILabel!
    @IBOutlet var day3: UILabel!
    @IBOutlet var temp1: UILabel!
    @IBOutlet var temp2: UILabel!
    @IBOutlet var temp3: UILabel!
    @IBOutlet var forecastStatus1: UIImageView!
    @IBOutlet var forecastStatus2: UIImageView!
    @IBOutlet var forecastStatus3: UIImageView!
    
    var cityID = Int32(1668341) //Taipei ID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCurrentWeather()
        setForeCastWeather()
    }
    
    //載入現在天氣
    func setCurrentWeather(){
        var json = weatherData.currentDataJSON(id: cityID)
        if !json.isEmpty{
            let main = json["main"] as! [String:Any]
            let sys = json["sys"] as! [String:Any]
            let weather = json["weather"] as! [[String:Any]]
            city.text = json["name"] as? String
            describeStaus.text = weather[0]["description"] as? String
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
            
            currentStatus.image = weatherPic(status: weather[0]["id"] as! Int)
            currentStatus.tintColor = .white
        }else{
            checkNetwork()
        }
    }
    
    //載入未來天氣，只使用三天的預測值
    func setForeCastWeather(){
        var forejson = weatherData.forcastDataJSON(id: cityID)
        if !forejson.isEmpty{
            var list = forejson["list"] as! [[String:Any]]
            let dateformat = DateFormatter()
            dateformat.dateFormat = "HH"
            
            let date1 = Date(timeIntervalSince1970: (list[0]["dt"] as? Double)!)
            let date2 = Date(timeIntervalSince1970: (list[1]["dt"] as? Double)!)
            let date3 = Date(timeIntervalSince1970: (list[2]["dt"] as? Double)!)
            let fore1 = list[0]["main"] as! [String:Any]
            let fore2 = list[1]["main"] as! [String:Any]
            let fore3 = list[2]["main"] as! [String:Any]
            let weather1 = list[0]["weather"] as! [[String:Any]]
            let weather2 = list[1]["weather"] as! [[String:Any]]
            let weather3 = list[2]["weather"] as! [[String:Any]]
            
            day1.text = "\(dateformat.string(from: date1))時"
            day2.text = "\(dateformat.string(from: date2))時"
            day3.text = "\(dateformat.string(from: date3))時"
            
            temp1.text = "\(convertDegree(fore1["temp"]!))°"
            temp2.text = "\(convertDegree(fore2["temp"]!))°"
            temp3.text = "\(convertDegree(fore3["temp"]!))°"
            
            forecastStatus1.image = weatherPic(status: weather1[0]["id"] as! Int)
            forecastStatus2.image = weatherPic(status: weather2[0]["id"] as! Int)
            forecastStatus3.image = weatherPic(status: weather3[0]["id"] as! Int)
            forecastStatus1.tintColor = .white
            forecastStatus2.tintColor = .white
            forecastStatus3.tintColor = .white
        }
    }
    
    //提醒檢查網路連線
    func checkNetwork(){
        let alertView: UIAlertView =  UIAlertView()
        alertView.title = "擷取資料失敗"
        alertView.message = "請重新檢查網路連線"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }
    
    func alertView(_ View: UIAlertView!, clickedButtonAtIndex buttonIndex:  Int){
        switch  buttonIndex{
        case  0:
            setCurrentWeather()
            setForeCastWeather()
        default:
            break;
        }
    }
    
    
    //轉換絕對溫度
    func convertDegree(_ degree: Any) -> Double{
        return (degree as! Double) - 273.15
    }
    
    //選擇天氣圖片
    func weatherPic(status: Int) -> UIImage{
        
        var a = "001lighticons-45.png"
        switch status {
        case 200..<300:
            a = "001lighticons-15.png"
        case 300..<400:
            a = "001lighticons-17.png"
        case 500..<600:
            a = "001lighticons-18.png"
        case 600..<700:
            a = "001lighticons-24.png"
        case 700..<800:
            a = "001lighticons-13.png"
        case 800:
            a = "001lighticons-2.png"
        case 801...805:
            a = "001lighticons-25.png"
        default:
            break
        }
        
        var template = UIImage(named: a)
        template = template?.withRenderingMode(.alwaysTemplate)
        
        return template!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

