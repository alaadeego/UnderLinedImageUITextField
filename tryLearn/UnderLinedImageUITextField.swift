//
//  UnderLinedImageUITextField.swift
//  tryLearn
//
//  Created by  alaa alrayes on 4/27/20.
//  Copyright © 2020 alrayes. All rights reserved.
//

import UIKit

class UnderLinedImageUITextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width:  self.frame.size.width-10, height: 1.0)
    }
          
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    
    @IBInspectable var color: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5) {
        didSet {
            updateView()
        }
    }
    @IBInspectable var placeholder_key: String = "" {
           didSet {
            self.placeholder = "placeholder_key.localized"
             /* self.textAlignment =  LanguageManager.isCurrentLanguageRTL() ? .right : .left*/
           }
         }

    private lazy var border: CALayer = {
        let border = CALayer()
        border.borderColor = UIColor.white.cgColor
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        return border
    }()
    private var borderWidth: CGFloat { 1 }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            // imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        
    }
    
    // Provides  padding between images and text
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 5)
    }
    /*
     override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
     return bounds.insetBy(dx: 10, dy: 5)
     }
     */
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    //Padding images on Right
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
}

