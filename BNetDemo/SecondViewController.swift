//
//  SecondViewController.swift
//  BNetDemo
//
//  Created by Alexandra Gorshkova on 29/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var da: UILabel!
    @IBOutlet weak var dm: UILabel!
  //  @IBOutlet weak var textData: UITextView!
    
    @IBOutlet weak var textDd: UITextView!
    var nameDa: String = ""
    var nameDM: String = ""
    var textD: String = ""
    
    
    //@IBOutlet weak var textData: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        da.text = nameDa
        dm.text = nameDM
        textDd.text = textD
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
