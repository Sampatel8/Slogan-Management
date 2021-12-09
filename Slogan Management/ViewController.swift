//
//  ViewController.swift
//  Slogan Management
//
//  Created by EbitNHP-i1 on 14/06/18.
//  Copyright © 2018 EbitNHP-i1. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var Slogantextfield: UITextField!
    var slogan : String?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBAction func submit(_ sender: UIButton) {
        if Slogantextfield?.text == ""
        {
            alertbox(title: "Worng..!", msg: "Please Enter Slogan First...!")
        }
        else
        {
            let newSlogan = NSEntityDescription.insertNewObject(forEntityName: "SloganTable",into : context)
                newSlogan.setValue(self.Slogantextfield!.text, forKey: "slogan")
                    
                alertbox(title: "Thank You..!", msg: "Your Slogan is Submited..!" )
                Slogantextfield.text=""
            }
        do{
            try context.save()
        }catch{
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if slogan != nil{
            Slogantextfield.text=slogan
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func alertbox(title: String, msg: String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

