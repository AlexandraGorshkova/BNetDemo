//
//  ViewController.swift
//  BNetDemo
//
//  Created by Alexandra Gorshkova on 27/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let newServices = Services()
    @IBOutlet weak var textMsg: UITextView!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBAction func back(_ sender: Any) {
        self.newServices.requestAdd(sessionId: sessionId, message: textMsg.text) {(result: Bool?, msgError:String?) in
            if msgError != nil {
                self.alert(message: msgError!)
            } else{
                DispatchQueue.main.async{
                    self.navigationController?.popViewController(animated: false)
                }
              //  self.navigationController?.popViewController(animated: false)
            }
            
        }
        
        
    }
    // @IBAction func backPressed(sender: UIButton){
        
    //}
    
    var sessionId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("se" + sessionId)
      // print(sessionId)
    
        
        
        
    }
    
    func alert(message: String){
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)//presentViewController(alert,anime)
    }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
   /*
    func alert(message: String){
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)//presentViewController(alert,anime)
    }
*/
//}


