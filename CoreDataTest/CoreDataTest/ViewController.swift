//
//  ViewController.swift
//  CoreDataTest
//
//  Created by 허예은 on 2022/01/09.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: self.container.viewContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        person.setValue("예은", forKey: "name")
        person.setValue("010-2345-6789", forKey: "number")
        
        do {
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let contact = try self.container.viewContext.fetch(Contact.fetchRequest()) as! [Contact]
            contact.forEach {
                print("\($0.name): \($0.number)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }


}

