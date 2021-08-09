//
//  SignInTextField.swift
//  Emotional Aid
//
//  Created by itay gervash on 09/08/2021.
//

import UIKit

class SignInTextField: UITextField {

    var padding: UIEdgeInsets

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.inset(by: padding)
       }

       override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.inset(by: padding)
       }

       override open func editingRect(forBounds bounds: CGRect) -> CGRect {
           return bounds.inset(by: padding)
       }
    
    init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.padding = padding
        super.init(frame: CGRect())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.init(coder: aDecoder)
    }
}
