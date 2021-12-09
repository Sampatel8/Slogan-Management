//
//  SloganTableViewController.swift
//  Slogan Management
//
//  Created by EbitNHP-i1 on 14/06/18.
//  Copyright © 2018 EbitNHP-i1. All rights reserved.
//

import UIKit
import CoreData

class SloganTableViewController: UITableViewController {

    var tslg : String?
    @IBOutlet var tableview: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var sloganArray:[SloganTable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
        navigationItem.rightBarButtonItem = editButtonItem
        self.tableview.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        switch(segue.identifier ?? "") {
            
        case "editData":
            
            guard let sloganDetailViewController = segue.destination as? ViewController
            else
        {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
       
        
        //MARK: GET THE ID
      //  let selectedslogan = selectedslogancell.sloganTextView.text
        sloganDetailViewController.slogan=tslg!
            
            break
        default:
            print("Segue Not Pewrform")
        
        }
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sloganArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
       let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = sloganArray[indexPath.row].slogan
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.adjustsFontSizeToFitWidth = true

        return cell
    }
   
    func fetchData()
    {
        do{
            sloganArray = try context.fetch(SloganTable.fetchRequest())
        }
        catch{
            print(error)
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let slog = sloganArray[indexPath.row]
            context.delete(slog)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                sloganArray = try context.fetch(SloganTable.fetchRequest())
                
            }catch{
                print(error)
                
            }
            tableview.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
   /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let slg = sloganArray[indexPath.row]
        tslg = slg.slogan
        
        performSegue(withIdentifier: "editData", sender: self)
        
    }*/
    
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //getting the index path of selected row
     let indexPath = tableView.indexPathForSelectedRow
     
     //getting the current cell from the index path
     let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
     
     //getting the text of that cell
     let currentSlogan = currentCell.textLabel!.text

     let alertController = UIAlertController(title: "Update Value", message: "" + currentSlogan! , preferredStyle: .alert)
     alertController.addTextField { (textField) in textField.text = currentSlogan!}
        
     alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
     let s = alertController.textFields![0]
    
     
     let  person  =  self.sloganArray[(indexPath?.row)!]
        if s.text != ""{
            
            person.setValue(s.text,  forKey:  "slogan")//update  age
        }
        else
        {
           self.alertbox(title: "Error...!!", msg: "TextField Cannot Be Empty....!!!😠")
        }
     do  {
     try  person.managedObjectContext?.save()
     self.tableView.reloadData()
     }
     catch  {
     let  saveError  =  error  as NSError
     print(saveError)
     
     }
    
     }))
     
     alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
     print("Handle Cancel Logic here")
     }))
     //let defaultAction = UIAlertAction(title: "Update", style: .default, handler: nil)
     //alertController.addAction(defaultAction)
     
     present(alertController, animated: true, completion: nil)
     }
    
    func alertbox(title: String, msg: String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
   /* override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }*/

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
   /* // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
