//
//  UIScreen+Extension.swift
//  MovieList
//
//  Created by Jiawei on 2022/5/13.
//

import UIKit

extension UIScreen {
    public static let screenWidth = UIScreen.main.bounds.width
    
    public static let screenHeight = UIScreen.main.bounds.height
}

extension UIColor {
    public convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
