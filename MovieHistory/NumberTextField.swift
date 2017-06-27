//
//  NumberTextField.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/06/02.
//  Copyright © 2017年 stash4. All rights reserved.
//

import UIKit

class NumberTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Controll Event
    
    // Called after loaded.
    override func awakeFromNib() {
        super.awakeFromNib()
        self.keyboardType = .numberPad
        //self.textAlignment = .right
    }
    
    // MARK: - Method
    
    func beginEditing() {
        guard let text = self.text else {
            return
        }
        self.text = text.replacingOccurrences(of: ",", with: "")
    }
    
    // Called after input values are changed.
    func shouldChange(range: NSRange, string: String) -> Bool {
        // Only numbers(0-9) are allowed.
        return string.isEmpty || string.range(of: "^[0-9]{4}$", options: .regularExpression) != nil
    }
    
}
