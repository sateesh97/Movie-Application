//
//  FavoritesCRUD.swift
//  project
//
//  Created by Vallivedu Sudhakar, Mohan on 11/8/20.
//  Copyright © 2020 UHCL. All rights reserved.
//

import UIKit
import CoreData

class FavoritesCRUD: NSObject {
    
    static func create(title:String, year:Int, id:String, poster:String) {
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            //Create a new empty record.
            let guessWordEntity = NSEntityDescription.entity(forEntityName: "Movies", in: managedContext)!
            //Fill the new record with values
            let guessword = NSManagedObject(entity: guessWordEntity, insertInto: managedContext)
            guessword.setValue(title, forKeyPath: "title")
            guessword.setValue(year, forKey: "year")
            guessword.setValue(id, forKey: "id")
            guessword.setValue(poster, forKey: "poster")
            do {
                //Save the managed object context
                try managedContext.save()
            } catch let error as NSError {
                print("Could not create the new record! \(error), \(error.userInfo)")
            }
        }
    }
    
    static func readData(attribute:String) -> [String]
    {
        var res = [String]()
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity (SELECT * FROM)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
            
            do {
                //Execute the fetch request
                let result = try managedContext.fetch(fetchRequest)
                if result.count > 0 {
                    for i in 0 ..< result.count
                    {
                        let rec = result[i] as! NSManagedObject
                        res.append(rec.value(forKey: attribute) as! String)
                    }
                }
                return res
            }
            catch let error as NSError {
                print("Could not fetch the record! \(error), \(error.userInfo)")
            }
        }
        return res
    }
    
    static func readYear() -> [Int]
    {
    //Get the managed context context from AppDelegate
        
        var years = [Int]()
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity (SELECT * FROM)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")

        do {
                    //Execute the fetch request
                    let result = try managedContext.fetch(fetchRequest)
                    if result.count > 0 {
                        for i in 0 ..< result.count
                        {
                            let rec = result[i] as! NSManagedObject
                            years.append(rec.value(forKey: "year") as! Int)
                        }
                    }
            return years
            }
            catch let error as NSError {
                print("Could not fetch the record! \(error), \(error.userInfo)")
            }
        }
        return years
    }
    
    
    static func delete(title:String) {
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare a fetch request for the record to delete
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
            fetchRequest.predicate = NSPredicate(format: "title = %@", title)
            
            do {
                //Fetch the record to delete
                let test = try managedContext.fetch(fetchRequest)
                
                //Delete the record
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    //Save the managed object context
                    try managedContext.save()
                }
                catch let error as NSError {
                    print("Could not delete the record! \(error), \(error.userInfo)")
                }
            }
            catch let error as NSError {
                print("Could not find the record to delete! \(error), \(error.userInfo)")
            }
            
        }
    }
    
    
    
    
}
