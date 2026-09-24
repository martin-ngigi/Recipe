/*
* Created by Martin Wainaina on 24/09/2026
*
* Feel free to contribute.
*/

//
//  UIImage.swift
//  Recipe
//
//  Created by RAFIKI on 24/09/2026.
//

import UIKit
import SwiftUI

extension UIImage {

    func averageColor() -> UIColor? {
        guard let cgImage else { return nil }

        let width = 40
        let height = 40

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        let bitsPerComponent = 8

        var data = [UInt8](repeating: 0, count: height * bytesPerRow)

        guard let context = CGContext(
            data: &data,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        context.draw(
            cgImage,
            in: CGRect(x: 0, y: 0, width: width, height: height)
        )

        var red = 0
        var green = 0
        var blue = 0
        var alpha = 0

        for y in 0..<height {
            for x in 0..<width {
                let index = (y * bytesPerRow) + (x * bytesPerPixel)

                red += Int(data[index])
                green += Int(data[index + 1])
                blue += Int(data[index + 2])
                alpha += Int(data[index + 3])
            }
        }

        let pixelCount = width * height

        return UIColor(
            red: CGFloat(red) / CGFloat(pixelCount) / 255,
            green: CGFloat(green) / CGFloat(pixelCount) / 255,
            blue: CGFloat(blue) / CGFloat(pixelCount) / 255,
            alpha: CGFloat(alpha) / CGFloat(pixelCount) / 255
        )
    }
}
