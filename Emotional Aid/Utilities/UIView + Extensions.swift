//
//  UIView + Extensions.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/06/2021.
//

import UIKit
import SnapKit

public extension UIView {
    
    var frameHeight: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    var frameWidth: CGFloat {
        get {
            return self.frame.size.width
        }
    }
    
    var widthModifier: CGFloat {
        get {
            return UIScreen.main.bounds.size.height / 812
        }
    }
    
    var heightModifier: CGFloat {
        get {
            return UIScreen.main.bounds.size.width / 375
        }
    }
    
    func circlize() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func uncirclize() {
        
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = true
        
    }
    
    func shadow(color: UIColor, radius: CGFloat, opacity: CGFloat = 0.5, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
     }
    
    func safeAreaSize(from direction: direction) -> CGFloat {
        let insets = UIApplication.shared.windows[0].safeAreaInsets
        let sizeArray = [insets.top, insets.right, insets.bottom, insets.left]
        return sizeArray[direction.rawValue]
    }
    
}

extension Date {
    func asString(format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func startOfDay() -> Date? {
        let calendar = Calendar.current
        return calendar.dateInterval(of: .day, for: self)?.start
    }
    
    func at(hour: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: hour, minute: 0, second: 0, of: self)
    }
    
    var inCurrentTimeZone: Date {
        get {
            let calendar = Calendar(identifier: .gregorian)
            let timezoneSecondOffset = TimeZone.current.secondsFromGMT()
            return calendar.date(byAdding: .second, value: timezoneSecondOffset, to: self) ?? self
        }
    }
}

extension UIViewController {
    
    var widthModifier: CGFloat {
        get {
            return self.view.frame.width / 375
        }
    }
    
    var heightModifier: CGFloat {
        get {
            return self.view.frame.height / 812
        }
    }
    
    var screenWidth: CGFloat {
        get {
            return self.view.frame.width
        }
    }
    
    var screenHeight: CGFloat {
        get {
            return self.view.frame.height
        }
    }
    
    func safeAreaSize(from direction: direction) -> CGFloat {
        let insets = UIApplication.shared.windows[0].safeAreaInsets
        let sizeArray = [insets.top, insets.right, insets.bottom, insets.left]
        return sizeArray[direction.rawValue]
    }
}

extension UIButton {

    func addTextSpacing(_ letterSpacing: CGFloat){
        if self.titleLabel?.text?.count == nil { self.setTitle("Title", for: .normal)}
        
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }

}

extension UILabel {
    
    func textSpacing(of spacing: CGFloat) {
        guard self.text != nil else { return }
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, self.text!.count))
        self.attributedText = attributedString
    }
    
    func setLineHeight(lineHeight: CGFloat) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.0
            paragraphStyle.lineHeightMultiple = lineHeight
            paragraphStyle.alignment = self.textAlignment

            let attrString = NSMutableAttributedString()
            if (self.attributedText != nil) {
                attrString.append( self.attributedText!)
            } else {
                attrString.append( NSMutableAttributedString(string: self.text!))
                attrString.addAttribute(NSAttributedString.Key.font, value: self.font ?? FontTypes.shared.p, range: NSMakeRange(0, attrString.length))
            }
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            self.attributedText = attrString
        }
    
}

extension CGFloat {
    func percentage(_ percent: Int) -> CGFloat {
        return self / 100 * CGFloat(percent)
    }
}

extension CACornerMask {
    static var allCorners: CACornerMask {
        get {
            return [CACornerMask.layerMaxXMaxYCorner, CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMinYCorner]
        }
    }
}

public enum direction: Int {
    case top = 0
    case right = 1
    case bottom = 2
    case left = 3
}
