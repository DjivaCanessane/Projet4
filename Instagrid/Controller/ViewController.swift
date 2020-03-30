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
        disableBackgroundImageOtherButtons()
        updateBackgroundImageForButton(sender)
        updateMainLayout(sender)
    }
    
    func disableBackgroundImageOtherButtons() {
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
        
        if sender == buttonLayout1 {
            let view1 = UIView()
            view1.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            let view2 = UIView()
            view2.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            let view3 = UIView()
            view3.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            topRow.addArrangedSubview(view1)
            bottomRow.addArrangedSubview(view2)
            bottomRow.addArrangedSubview(view3)
            return
        }
        else if sender == buttonLayout2 {
            let view1 = UIView()
            view1.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            let view2 = UIView()
            view2.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            let view3 = UIView()
            view3.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            topRow.addArrangedSubview(view1)
            topRow.addArrangedSubview(view2)
            bottomRow.addArrangedSubview(view3)
            return
        }
        else if sender == buttonLayout3 {
            let view1 = UIView()
            view1.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            let view2 = UIView()
            view2.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            let view3 = UIView()
            view3.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            let view4 = UIView()
            view4.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            topRow.addArrangedSubview(view1)
            topRow.addArrangedSubview(view2)
            bottomRow.addArrangedSubview(view3)
            bottomRow.addArrangedSubview(view4)
            return
        }
    }
    
    func resetRows() {
        
        for view in topRow.subviews {
            topRow.removeArrangedSubview(view)
        }
        
        for view in bottomRow.subviews {
            bottomRow.removeArrangedSubview(view)
        }
    }
    
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        
        // Select initialy the first button
        buttonLayout1.setBackgroundImage(UIImage(named: "Selected"), for: .normal)
        
        // Set mainLayout to first button's layout
        showMainLayout(buttonLayout1)
        
    }
    
    
}

