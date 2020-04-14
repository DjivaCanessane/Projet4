//
//  ViewController.swift
//  Instagrid
//
//  Created by Djiva Canessane on 27/03/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var swipeArrowImage: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    @IBOutlet weak var buttonLayout3: UIButton!
    @IBOutlet weak var topRow: UIStackView!
    @IBOutlet weak var bottomRow: UIStackView!
    @IBOutlet weak var mainView: UIView!
    
    private var buttonBuffer: UIButton = UIButton()
    private var swipeGestureRecognier: UISwipeGestureRecognizer!
    private var transformAnimation: CGAffineTransform?
    
    @objc private func onSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            animateMainView()
        }
    }
    
    private func animateMainView() {
        UIView.animate(withDuration: 0.5, animations: {
            guard let transformAnimation = self.transformAnimation else { return }
            self.mainView.transform = transformAnimation
        }, completion: { (isSwipped) in
            if isSwipped {
                self.share()
            }
            
        })
    }
    
    private func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    private func share() {
        guard let image: UIImage = image(with: mainView) else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            self.resetPositionMainView()
        }
    }
    
    private func resetPositionMainView() {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
                self.mainView.transform = .identity
            }, completion: nil)
    }
    
    @IBAction private func buttonActionLayoutTapped(_ sender: UIButton) {
        print(#function)
        disableBackgroundImageBottomButtons()
        updateBackgroundImageForButton(sender)
        updateMainLayout(sender)
    }
    
    private func disableBackgroundImageBottomButtons() {
        buttonLayout1.setImage(.none, for: .normal)
        buttonLayout2.setImage(.none, for: .normal)
        buttonLayout3.setImage(.none, for: .normal)
    }
    
    private func updateBackgroundImageForButton(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Selected"), for: .normal)
    }
    
    private func updateMainLayout(_ sender: UIButton) {
        animateToRemoveMainLayout(sender)
    }
    
    private func animateToRemoveMainLayout(_ sender: UIButton) {
        UIView.animate(withDuration: 0.6, animations: {
            self.mainView.transform = CGAffineTransform(scaleX: 2, y: 4)
            self.mainView.alpha = 0
        }, completion: { (isComplete) in
            self.resetRows()
            self.showMainLayout(sender)
            
        })
    }
    
    private func showMainLayout(_ sender: UIButton) {
        
        self.mainView.transform = .identity
        UIView.animate(withDuration: 0.2, animations: {
            self.mainView.alpha = 1
            self.setRows(sender)
        }, completion: nil)
    }
    
    private func setRows(_ sender: UIButton) {
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
    
    @objc private func addPhotoFromLibrary(sender: UIButton) {
        buttonBuffer = sender
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.sourceType = .photoLibrary
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            buttonBuffer.setImage(originalImage, for: .normal)
            buttonBuffer.imageView?.contentMode = .scaleAspectFill
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func makeAddButton(count: Int) -> [UIButton] {
        var buttons: [UIButton] = []
        for _ in 1...count {
            let button = UIButton()
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.setImage(UIImage(named: "Plus"), for: .normal)
            button.addTarget(self, action: #selector(addPhotoFromLibrary(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }
    
    private func resetRows() {
        
        for view in topRow.subviews {
            view.removeFromSuperview()
            
        }
        
        for view in bottomRow.subviews {
            view.removeFromSuperview()
        }
    }
    
    @objc private func resetOrientation() {
        var windowInterfaceOrientation: UIInterfaceOrientation? {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
            } else {
                return UIApplication.shared.statusBarOrientation
            }
        }
        guard let interfaceOrientation = windowInterfaceOrientation else { return }
        if interfaceOrientation.isPortrait {
            swipeGestureRecognier.direction = .up
            swipeLabel.text = "Swipe up to share"
            swipeArrowImage.image = UIImage(named: "Arrow Up")
            transformAnimation = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        } else {
            swipeGestureRecognier.direction = .left
            swipeLabel.text = "Swipe left to share"
            swipeArrowImage.image = UIImage(named: "Arrow Left")
            transformAnimation = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Select initialy the first button
        buttonLayout1.setImage(UIImage(named: "Selected"), for: .normal)
        
        // Set mainLayout to first button's layout
        showMainLayout(buttonLayout1)
        
        swipeGestureRecognier = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        
        
        rootView.addGestureRecognizer(swipeGestureRecognier)
        NotificationCenter.default.addObserver(self, selector: #selector(resetOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    
}

