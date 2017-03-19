//
//  CityList.swift
//  weatherApp
//

import UIKit
import CoreData

class CityList{
    let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    fileprivate var cities = [City]()
    fileprivate var CityID = [String]()
    fileprivate var cityName = [String]()
    
    init(){}
    
    func getFilteredCity(name: String) -> [City]{
        cities = City.getFilterCity(moc, name: name)
        return cities
    }
    
    func addFavCity(id: Int32){
        City.addFavCity(moc, id: id)
        print("加入\(id)")
    }
    
    func delFavCity(id: Int32){
        City.delFavCity(moc, id: id)
        print("刪除\(id)")
    }
    
    func getFavCity()-> [City]{
        cities = City.getFavCity(moc)
        return cities
    }
}
