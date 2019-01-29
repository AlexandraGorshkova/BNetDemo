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
    //var data
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
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func alert(message: String){
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)//presentViewController(alert,anime)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataCell
        let item = entries[indexPath.row]
        
        //name = entries[indexPath.row].da
        cell.da.text = entries[indexPath.row].da
        cell.dm.text = entries[indexPath.row].dm
        
        if entries[indexPath.row].body.count > 200 {
            //cell.dataText.text = entries[indexPath.row].body[1...200]//item[indexPath.row]
            let index = item.body.index(item.body.startIndex, offsetBy: 200)
           let mySubstring = item.body[..<index]
            cell.dataText.text = String(mySubstring)
        } else {
            cell.dataText.text = item.body }
        //prepare(for: "detailSegue", sender: self)
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
                //self.entries[indexPath]
                
            
            }
        }
        
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


