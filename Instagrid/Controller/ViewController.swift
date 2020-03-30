//
//  ViewController.swift
//  Instagrid
//
//  Created by Djiva Canessane on 27/03/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    @IBOutlet weak var buttonLayout3: UIButton!
    @IBOutlet weak var topRow: UIStackView!
    @IBOutlet weak var bottomRow: UIStackView!
    
    @IBAction func buttonActionLayoutTapped(_ sender: UIButton) {
        print(#function)
        disableBackgroundImageOtherButtons()
        updateBackgroundImageForButton(sender)
        
    }
    
    func disableBackgroundImageOtherButtons() {
        buttonLayout1.setBackgroundImage(nil, for: .normal)
        buttonLayout2.setBackgroundImage(nil, for: .normal)
        buttonLayout3.setBackgroundImage(nil, for: .normal)
    }
    
    func updateBackgroundImageForButton(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "Selected"), for: .normal)
    }
    
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        buttonLayout1.setBackgroundImage(UIImage(named: "Selected"), for: .normal)
        
    }
    
    
}

