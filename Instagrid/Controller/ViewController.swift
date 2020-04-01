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
    @IBOutlet weak var mainLayout: UIView!
    
    @IBAction func buttonActionLayoutTapped(_ sender: UIButton) {
        print(#function)
        disableBackgroundImageBottomButtons()
        updateBackgroundImageForButton(sender)
        updateMainLayout(sender)
    }
    
    func disableBackgroundImageBottomButtons() {
        buttonLayout1.setBackgroundImage(nil, for: .normal)
        buttonLayout2.setBackgroundImage(nil, for: .normal)
        buttonLayout3.setBackgroundImage(nil, for: .normal)
    }
    
    func updateBackgroundImageForButton(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "Selected"), for: .normal)
    }
    
    func updateMainLayout(_ sender: UIButton) {
        animateToRemoveMainLayout(sender)
    }
    
    func animateToRemoveMainLayout(_ sender: UIButton) {
        UIView.animate(withDuration: 0.6, animations: {
            self.mainLayout.transform = CGAffineTransform(scaleX: 2, y: 4)
            self.mainLayout.alpha = 0
        }, completion: { (isComplete) in
            self.resetRows()
            self.showMainLayout(sender)
            
        })
    }
    
    func showMainLayout(_ sender: UIButton) {
        
        self.mainLayout.transform = .identity
        UIView.animate(withDuration: 0.2, animations: {
            self.mainLayout.alpha = 1
            self.setRows(sender)
        }, completion: nil)
    }
    
    func setRows(_ sender: UIButton) {
        let buttons: [UIButton]
        if sender == buttonLayout1 {
            buttons = makeAddButton(count: 3)
            topRow.addArrangedSubview(buttons[0])
            bottomRow.addArrangedSubview(buttons[1])
            bottomRow.addArrangedSubview(buttons[2])
            return
        }
        else if sender == buttonLayout2 {
            buttons = makeAddButton(count: 3)
            topRow.addArrangedSubview(buttons[0])
            topRow.addArrangedSubview(buttons[1])
            bottomRow.addArrangedSubview(buttons[2])
            return
        }
        else if sender == buttonLayout3 {
            buttons = makeAddButton(count: 4)
            topRow.addArrangedSubview(buttons[0])
            topRow.addArrangedSubview(buttons[1])
            bottomRow.addArrangedSubview(buttons[2])
            bottomRow.addArrangedSubview(buttons[3])
            return
        }
    }
    
    @objc func addPhotoFromLibrary(sender: UIButton) {
        
    }
    
    func makeAddButton(count: Int) ->[UIButton] {
        var buttons: [UIButton] = []
        for _ in 1...count {
            let button = UIButton()
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.setBackgroundImage(UIImage(named: "Plus"), for: .normal)
            button.addTarget(self, action: #selector(addPhotoFromLibrary(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }
    
    func resetRows() {
        
        for view in topRow.subviews {
            view.removeFromSuperview()
            
        }
        
        for view in bottomRow.subviews {
            view.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Select initialy the first button
        buttonLayout1.setBackgroundImage(UIImage(named: "Selected"), for: .normal)
        
        // Set mainLayout to first button's layout
        showMainLayout(buttonLayout1)
        
    }
    
    
}

