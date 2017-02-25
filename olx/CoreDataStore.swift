//
//  CoreDataStore.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit
import CoreData

private let kProductEntityName = "Product"

private let _sharedInstance = CoreDataStore()

class CoreDataStore
{
    init()
    {
        
    }
    
    class var sharedInstance : CoreDataStore
    {
        return _sharedInstance
    }
    
    func fetchEntriesWithPredicate(_ predicate: NSPredicate, completionBlock: ((ManagedProduct?) -> Void)!) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest(entityName: kProductEntityName)
        fetchRequest.predicate = predicate
        
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            let queryResults = try? managedObjectContext.fetch(fetchRequest)
            if let managedResults = queryResults! as? [ManagedProduct] {
                if managedResults.count > 0 {
                    completionBlock(managedResults.first!)
                }else {
                    completionBlock(nil)
                }
            }else {
                completionBlock(nil)
            }
        }catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            completionBlock?(nil)
        }
        
        
    }
    
    func fetchProductEntries(completionBlock: (([ManagedProduct]) -> Void)!) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest(entityName: kProductEntityName)
        
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            let queryResults = try? managedObjectContext.fetch(fetchRequest)
            let managedResults = queryResults! as! [ManagedProduct]
            completionBlock(managedResults)
        }catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func newProductItem() -> ManagedProduct {
        
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let newEntry = NSEntityDescription.insertNewObject(forEntityName: kProductEntityName, into: managedObjectContext) as! ManagedProduct
        return newEntry
    }
    
    func save(productList : [Product]) {
        
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: kProductEntityName, in:managedContext)
        for product in productList
        {
            let productObject = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            if let title = product.title {
                productObject.setValue(title, forKey: "title")
            }else {
                productObject.setValue("--", forKey: "title")
            }
            
            if let description = product.description {
                productObject.setValue(description, forKey: "discription")
            }else {
                productObject.setValue("--", forKey: "discription")
                
            }
            
            if let displayLocation = product.displayLocation {
                productObject.setValue(displayLocation, forKey: "displayLocation")
            }else {
                productObject.setValue("--", forKey: "displayLocation")

            }
            
            if let fullImageUrl = product.fullImageURL {
                productObject.setValue(fullImageUrl, forKey: "fullImageURL")
            }else {
                productObject.setValue("--", forKey: "fullImageURL")

            }
            
            if let id = product.id {
                productObject.setValue(id, forKey: "identifier")
            }else {
                productObject.setValue("--", forKey: "identifier")

            }
            
            if let thumbnailUrl = product.thumbnailURL {
                productObject.setValue(thumbnailUrl, forKey: "imageUrl")
            }else {
                productObject.setValue("--", forKey: "imageUrl")
            }
            
            if let price = product.price {
                productObject.setValue(price, forKey: "price")
            }else {
                productObject.setValue("--", forKey: "price")

            }
            
            do {
                try managedContext.save()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteAllProducts () {
        
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: kProductEntityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try managedObjectContext.execute(request)
            print("success delete")
        }catch {
            print("error deletion")
        }
    }
}
