//
//  ColorObjects.swift
//  BackgroundColorChanger
//
//  Created by cpsc on 11/9/20.
// this object saves all the colors
// we will save the "color manager" object instead of colors individually

import Foundation

struct ColorManager: Codable {
    static var colorCollection: [Color] = []
}
struct Color: Codable {
    var red: Int = 255
    var green: Int = 255
    var blue: Int = 255
    var alpha: Int = 255
}
