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
    @IBOutlet weak var textDd: UITextView!
    var nameDa: String = ""
    var nameDM: String = ""
    var textD: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        da.text = nameDa
        dm.text = nameDM
        textDd.text = textD
    }
}
