//
//  Misc.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 5/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

let fontName = "HiraginoSans-W3"
class Screen {
    
    
    static let screenSize = UIScreen.main.bounds
    
    static var heightOverWidth: CGFloat!
    
    static func setup(){
        Screen.heightOverWidth = (Screen.screenSize.height / Screen.screenSize.width)
    }

    static func getScreenPos(x: CGFloat, y: CGFloat) -> CGPoint{
        return CGPoint(x: x * screenSize.width, y: y * screenSize.height)
    }
    
    static func getScreenSize(x: CGFloat, y: CGFloat) -> CGSize{
        return CGSize(width: x * screenSize.width, height: y * screenSize.height)
    }
    
    static func getClampedScreenPosition(_ x: CGFloat, y: CGFloat) -> CGPoint{
        return CGPoint(x: (x / screenSize.width), y: (y / screenSize.height))
    }
    
    static func getActualSize(_ width: CGFloat, height: CGFloat) -> CGSize{
        return CGSize(width: width * screenSize.width, height: height * screenSize.height)
    }
    
    //TODO: Return a font size that is the same for all devices.
    // A base ratio used from one device that is mimiced in all other devices?
    static func fontSize(fontSize: CGFloat) -> CGFloat{
        return ((fontSize*Screen.heightOverWidth)/1.77866666666667)*Screen.screenSize.width/36
    }
}

class Functions {
    
    static func randomColor() -> UIColor {
        let r: CGFloat = CGFloat(randomInt(70, max: 250))
        let g: CGFloat = CGFloat(randomInt(70, max: 250))
        let b: CGFloat = CGFloat(randomInt(70, max: 250))
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 0.8)
    }
    
    static func inverseColor(_ color: UIColor) -> UIColor{
        var a: CGFloat = 0.0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: 1-r, green: 1-g, blue: 1-b, alpha: a)
    }
    
    static func randomInt(_ min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    static func randomFloat(_ minimum: CGFloat, maximum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(minimum - maximum) + min(minimum, maximum)
    }
    
    static func randomRadian() -> CGFloat{
        return randomFloat(0, maximum: CGFloat(M_PI*2))
    }
    
    static func randomUInt8(_ min: UInt8, max: UInt8) -> UInt8 {
        return min + UInt8(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    static func lerpf(_ a: CGFloat, b: CGFloat, t: CGFloat) -> CGFloat{
        return a + (b - a) * t
    }
    
    static func lerpColor(_ a: UIColor, b: UIColor, t: CGFloat) -> UIColor{
        let c = UIColor(colorLiteralRed: Float(lerpf(CGFloat(a.components.red), b: CGFloat(b.components.red), t: t)), green: Float(lerpf(CGFloat(a.components.green), b: CGFloat(b.components.green), t: t)), blue: Float(lerpf(CGFloat(a.components.blue), b: CGFloat(b.components.blue), t: t)), alpha: Float(lerpf(CGFloat(a.components.alpha), b: CGFloat(b.components.alpha), t: t)))
        
        return c
    }
}

struct Range {
    var Min: CGFloat
    var Max: CGFloat
    
    init(min: CGFloat, max: CGFloat){
        Min = min
        Max = max
    }
}

extension UIColor {
    var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
    
    func GetDarkerColor(_ amount: CGFloat) -> UIColor{
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * amount, alpha: a)
        }
        return self
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * M_PI / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / M_PI }
}

extension Double {
    var degreesToRadians: Double { return self * M_PI / 180 }
    var radiansToDegrees: Double { return self * 180 / M_PI }
}

extension CGFloat {
    var doubleValue:      Double  { return Double(self) }
    var degreesToRadians: CGFloat { return CGFloat(doubleValue * M_PI / 180) }
    var radiansToDegrees: CGFloat { return CGFloat(doubleValue * 180 / M_PI) }
}

extension Float  {
    var doubleValue:      Double { return Double(self) }
    var degreesToRadians: Float  { return Float(doubleValue * M_PI / 180) }
    var radiansToDegrees: Float  { return Float(doubleValue * 180 / M_PI) }
}

extension CGPoint{
    public static var outOfScreen: CGPoint { return Screen.getScreenPos(x: -1, y: -1) }
}

extension UIColor {
    
    class func turquioseColor() -> UIColor {
        return UIColor(red: 26.0/255.0, green: 188.0/255.0, blue:156.0/255.0, alpha: 1.0)
    }
    
    class func greenSeaColor() -> UIColor {
        return UIColor(red: 22.0/255.0, green: 160.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    }
    
    class func emeraldColor() -> UIColor {
        return UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
    }
    
    class func nephritisColor() -> UIColor {
        return UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    }
    
    class func peterRiverColor() -> UIColor {
        return UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    }
    
    class func belizeHoleColor() -> UIColor {
        return UIColor(red: 41.0/255.0, green: 128.0/255.0, blue: 185.0/255.0, alpha: 1.0)
    }
    
    class func amethystColor() -> UIColor {
        return UIColor(red: 155.0/255.0, green: 89.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    }
    
    class func wisteriaColor() -> UIColor {
        return UIColor(red: 142.0/255.0, green: 68.0/255.0, blue: 173.0/255.0, alpha: 1.0)
    }
    
    class func wetAsphaltColor() -> UIColor {
        return UIColor(red: 52.0/255.0, green: 73.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    }
    
    class func midnightBlueColor() -> UIColor {
        return UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0)
    }
    
    class func sunFlowerColor() -> UIColor {
        return UIColor(red: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1.0)
    }
    
    class func orangeFlatColor() -> UIColor {
        return UIColor(red: 243.0/255.0, green: 156.0/255.0, blue: 18.0/255.0, alpha: 1.0)
    }
    
    class func carrotColor() -> UIColor {
        return UIColor(red: 230.0/255.0, green: 126.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    }
    
    class func pumpkinColor() -> UIColor {
        return UIColor(red: 211.0/255.0, green: 84.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    class func alizarinColor() -> UIColor {
        return UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }
    
    class func pomegranateColor() -> UIColor {
        return UIColor(red: 192.0/255.0, green: 57.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    }
    
    class func cloudsColor() -> UIColor {
        return UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    }
    
    class func silverColor() -> UIColor {
        return UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    }
    
    class func concreteColor() -> UIColor {
        return UIColor(red: 149.0/255.0, green: 165.0/255.0, blue: 166.0/255.0, alpha: 1.0)
    }
    
    class func asbestosColor() -> UIColor {
        return UIColor(red: 127.0/255.0, green: 140.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    }
}

