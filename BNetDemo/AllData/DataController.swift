//
//  DataController.swift
//  BNetDemo
//
//  Created by Alexandra Gorshkova on 27/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import UIKit


class DataController: UITableViewController {
    
    let newServices = Services()
    var sessionId = ""
    var entries: [DataEntity] = [DataEntity]()
    var name : String?// = "" 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (!sessionId.isEmpty) {
            newServices.requestEntites(sessionId: self.sessionId){(result: [DataEntity]?, errorMsg: String?) in
                if errorMsg != nil {
                    self.alert(message: errorMsg ?? "")
                } else {
                    self.entries = result!
                    DispatchQueue.main.async{
                         self.tableView.reloadData()
                    }  
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            alert(message:"Включите интернет")
        }
        
        
        newServices.request { (sessionId: String?, errorMsg: String?) in
            if errorMsg != nil {
                self.alert(message: errorMsg ?? "")
            } else {
                self.sessionId = sessionId!
                print("session " + self.sessionId)
                self.newServices.requestEntites(sessionId: self.sessionId){(result: [DataEntity]?, errorMsg: String?) in
                    if errorMsg != nil {
                        self.alert(message: errorMsg ?? "")
                    } else {
                        self.entries = result!
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func alert(message: String){
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)//presentViewController(alert,anime)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataCell
        let item = entries[indexPath.row]
        
        //name = entries[indexPath.row].da
        cell.da.text = entries[indexPath.row].da
        cell.dm.text = entries[indexPath.row].dm
        
        if entries[indexPath.row].body.count > 200 {
            let index = item.body.index(item.body.startIndex, offsetBy: 200)
           let mySubstring = item.body[..<index]
            cell.dataText.text = String(mySubstring)
        } else {
            cell.dataText.text = item.body }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
        var destinationVC: ViewController = segue.destination as! ViewController
        destinationVC.sessionId = sessionId
        }
        
        
        if segue.identifier == "detailSegue" {
            if let indexP = tableView.indexPathForSelectedRow{
                var dvc = segue.destination as! SecondViewController
                dvc.nameDa = entries[indexP.row].da
                dvc.nameDM = entries[indexP.row].dm
                dvc.textD = entries[indexP.row].body
            }
        }   
    }
}
