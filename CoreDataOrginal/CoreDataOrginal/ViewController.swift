//
//  ViewController.swift
//  CoreDataOrginal
//
//  Created by Demo 01 on 20/04/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit
import CoreData
import PhotosUI


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var img: UIImageView!
    
        var arr = [Employee]()
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var salaryTxt: UITextField!
    
    @IBOutlet weak var idTxt: UITextField!
    
    @IBOutlet weak var profiletext: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
        
    }
    
    let imageName = UUID().uuidString
    @IBAction func saveBtn(_ sender: Any) {
      
       
        let entity = NSEntityDescription.entity(forEntityName:"Employee", in:context)
        let emp = NSManagedObject(entity:entity!,insertInto:context)
        emp.setValue(idTxt.text,forKey:"empId")
        emp.setValue(nameTxt.text,forKey:"empName")
        emp.setValue(salaryTxt.text,forKey:"salary")
        emp.setValue(profiletext.text,forKey:"profile")
        emp.setValue(img.image, forKey: imageName )
        do {
                try context.save()
            print("save")
            nameTxt.text = ""
            idTxt.text = ""
            salaryTxt.text = ""
            profiletext.text = ""
            tableView.reloadData()
        } catch  {
            print("error")
        }
    }
    
    func fetchData(){
           
            let fetch = NSFetchRequest<Employee>(entityName: "Employee")
            do{
                arr = try context.fetch(fetch)
                tableView.reloadData()
                print(arr)
            }catch{
                print("erorooro")
            }
    }
   

}


extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.lbl.text = arr[indexPath.row].empId! + " " + arr[indexPath.row].empName! + " " +  arr[indexPath.row].salary! + " " +  arr[indexPath.row].profile!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            self.arr.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
