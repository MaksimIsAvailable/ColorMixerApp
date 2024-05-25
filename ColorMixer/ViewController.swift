//
//  ViewController.swift
//  ColorMixer
//
//  Created by Maksim on 24.05.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstColorLabel: UILabel!
    @IBOutlet weak var secondColorLabel: UILabel!
    
    @IBOutlet weak var firstColor: UIButton!
    @IBOutlet weak var secondColor: UIButton!
    @IBOutlet weak var resultView: UIView!
    
    
    var activeButton: UIButton?
    var selectedColor1: UIColor?
    var selectedColor2: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstColor.addTarget(self, action: #selector(firstColorPressed(_:)), for: .touchUpInside)
        secondColor.addTarget(self, action: #selector(secondColorPressed(_:)), for: .touchUpInside)
    }

    @IBAction func firstColorPressed(_ sender: UIButton) {
        activeButton = sender
        presentColorPicker()
    }
    
    @IBAction func secondColorPressed(_ sender: UIButton) {
        activeButton = sender
        presentColorPicker()
    }
    
    func presentColorPicker() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    func mixColors() {
        guard let color1 = selectedColor1, let color2 = selectedColor2 else {
            return
        }
        
        let components1 = color1.cgColor.components!
        let components2 = color2.cgColor.components!
        
        let red = (components1[0] + components2[0]) / 2
        let green = (components1[1] + components2[1]) / 2
        let blue = (components1[2] + components2[2]) / 2
        
        let mixedColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        resultView.backgroundColor = mixedColor
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        if selectedColor1 == nil {
            selectedColor1 = viewController.selectedColor
            firstColor.backgroundColor = selectedColor1
        } else {
            selectedColor2 = viewController.selectedColor
            secondColor.backgroundColor = selectedColor2
            mixColors()
        }
    }
    
}


