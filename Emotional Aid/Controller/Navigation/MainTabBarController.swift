//
//  MainTabBarController.swift
//  Emotional Aid
//
//  Created by itay gervash on 25/06/2021.
//

import UIKit
import SnapKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = tabBarVCs()
    }
    
    override func viewDidLayoutSubviews() {
        setTabBarPreferences()
    }
    

    func tabBarVCs() -> [UIViewController] {
        
        let mainVC = NavigationController(rootViewController: MainViewController())
                 
         mainVC.tabBarItem = UITabBarItem(title: "Практика", image: UIImage(named: "practice_tabbar"), tag: 0)

         let theoryVC = TheoryViewController()

         theoryVC.tabBarItem = UITabBarItem(title: "Теория", image: UIImage(named: "theory_tabbar"), tag: 1)

         let tabBarList = [theoryVC, mainVC]

        return tabBarList
    }
    
    func setTabBarPreferences() {
        
        //set tab bar position and size
        setTabBarHeight(to: 64)
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemWidth = screenWidth / 2.75
        
        //set tab bar corners
        self.tabBar.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: self.tabBar.frameHeight.percentage(10))
        self.tabBar.layer.shouldRasterize = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //set tab bar design and properties
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = K.colors.appRed
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //padding corrections for tab bar items
        for item in tabBar.items ?? [] {
            item.setTitleTextAttributes([NSAttributedString.Key.font : FontTypes.shared.ubuntu.withSize(13)], for: .normal)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5 * heightModifier)
            
            // visual correction for practice image
            if item.tag == 0 { item.imageInsets.left = 4 * widthModifier}
        }
        
        
        
        //add tab bar shadow layer
        self.view.layer.addSublayer(generateShadowLayerFor(self.tabBar, shadowColor: .black, shadowRadius: tabBar.frameHeight.percentage(7)))
        
        self.selectedIndex = 1
        
        
    }
    
    func setTabBarHeight(to height: Int) {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = CGFloat(height) * heightModifier + self.safeAreaSize(from: .bottom)
        print(safeAreaSize(from: .bottom))
        tabFrame.origin.y = self.view.frame.size.height - CGFloat(height) - self.safeAreaSize(from: .bottom)
        self.tabBar.frame = tabFrame
    }
    
    func generateShadowLayerFor(_ parentView: UIView, shadowColor color: UIColor, shadowRadius radius: CGFloat) -> CALayer {
        
        let shadowLayer = CALayer()
            shadowLayer.frame = parentView.frame
            shadowLayer.backgroundColor = UIColor.white.cgColor
            shadowLayer.cornerRadius = parentView.layer.cornerRadius; print("corner radius:", parentView.layer.cornerRadius)
            shadowLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
            shadowLayer.shadowColor = color.cgColor
            shadowLayer.shadowRadius = radius
            shadowLayer.shadowOpacity = 0.05

            // This is important so the shadow doesn't lag content
            // which is scrolling underneath it.
            shadowLayer.shouldRasterize = true
            shadowLayer.rasterizationScale = UIScreen.main.scale

            // The shadow path is needed because a shadow won't
            // display for a layer with a clear backgroundColor
            let shadowPath = UIBezierPath(roundedRect: shadowLayer.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: parentView.layer.cornerRadius , height: parentView.layer.cornerRadius))

            // The mask makes it so that the shadow doesn't draw on
            // top of the tab bar, filling in the whole layer
            let maskLayer = CAShapeLayer()
            let maskPath = CGMutablePath()

            // This path goes around the outside of the possible shadow radius, so that the
            // shadow is between this path and the tap bar
        maskPath.addRect(CGRect(x: -radius*2, y: -radius*2, width: shadowLayer.frame.width + (radius * 2), height: shadowLayer.frame.height + (radius*2)))

            // The shadow path (shape of the tab bar) is drawn on the inside
            maskPath.addPath(shadowPath.cgPath)
            maskLayer.path = maskPath

            // This makes it so that the only shadow layer content that will
            // be drawn is located in between the two above paths
            maskLayer.fillRule = .evenOdd
            shadowLayer.mask = maskLayer
        
            return shadowLayer
    }


}
