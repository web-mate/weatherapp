//
//  customInputField.swift
//  weatherApplication
//
//  Created by dimitris vlagas on 29/8/16.
//  Copyright © 2016 webmate. All rights reserved.
//

import UIKit

@IBDesignable

class customLabel: UILabel {
    
    @IBInspectable var fontColor: UIColor = UIColor.whiteColor(){
        didSet{
            self.textColor = fontColor
        }
    }
    
    override func awakeFromNib() {
        self.textColor = UIColor.whiteColor()
    self.font = UIFont(name: "Helvetica-bold", size: self.font.pointSize)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.textColor = fontColor
         self.font = UIFont(name: "Helvetica-bold", size: self.font.pointSize)
    }
    
}
