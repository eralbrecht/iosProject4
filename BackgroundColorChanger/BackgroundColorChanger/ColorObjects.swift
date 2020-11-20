//
//  ColorObjects.swift
//  BackgroundColorChanger
//
//  Created by cpsc on 11/9/20.
// this object saves all the colors
// we will save the "color manager" object instead of colors individually

import Foundation
import UIKit

struct ColorManager: Codable {
    static var colorCollection: [Color] = []
}
struct Color: Codable {
    var red: Int = 255
    var green: Int = 255
    var blue: Int = 255
    var alpha: Int = 255
    
    func GetHex() -> String{//make hexcode
        return String(format: "%02lX%02lX%02lX%02lX",
                      self.red,
                      self.green,
                      self.blue,
                      self.alpha
        )
    }
    //make image of a size and shape and fill it with a color
    func GetImage() -> UIImage {
        let inputRed = CGFloat(self.red)/255
        let inputGreen = CGFloat(self.green)/255
        let inputBlue = CGFloat(self.blue)/255
        let inputAlpha = CGFloat(self.alpha)/255
        
        let uiColor = UIColor(red: inputRed, green: inputGreen, blue: inputBlue, alpha: inputAlpha)
        
        return uiColor.imageWithColor(width: 20, height: 20)
        
    }
    
}

extension UIColor {
    func imageWithColor(width: Int, height: Int) -> UIImage{
        let size = CGSize(width: width, height: height)
        //UIGraphicsInageRenderer(size: size).image(actions: (UIGraphicsImageRendererContext) -> Void)
        return UIGraphicsImageRenderer(size: size).image {
            rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
