//
//  City+CoreDataClass.swift
//  weatherApp
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject {
    
    //取得搜尋的城市結果
    class func getFilterCity(_ moc:NSManagedObjectContext, name: String) -> [City] {
        let condition = "name CONTAINS[cd] '\(name)' and fav = '0'"
        var request: NSFetchRequest<City>
        request = City.fetchRequest()
        request.predicate = NSPredicate(format: condition,"")
        
        do {
            return try moc.fetch(request)
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    //加入最愛的城市
    class func addFavCity(_ moc:NSManagedObjectContext, id: Int32){
        let condition = "id CONTAINS[cd] '\(id)'"
        var request: NSFetchRequest<City>
        request = City.fetchRequest()
        request.predicate = NSPredicate(format: condition,"")
        
        do {
            var item = try moc.fetch(request)
            item[0].fav = true
            try moc.save()
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    //刪除最愛的城市
    class func delFavCity(_ moc:NSManagedObjectContext, id: Int32){
        let condition = "id CONTAINS[cd] '\(id)'"
        var request: NSFetchRequest<City>
        request = City.fetchRequest()
        request.predicate = NSPredicate(format: condition,"")
        
        do {
            var item = try moc.fetch(request)
            item[0].fav = false
            try moc.save()
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    //取得最愛的城市
    class func getFavCity(_ moc:NSManagedObjectContext) -> [City] {
        let condition = "fav = '1'"
        var request: NSFetchRequest<City>
        request = City.fetchRequest()
        request.predicate = NSPredicate(format: condition,"")
        
        do {
            return try moc.fetch(request)
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }
}
