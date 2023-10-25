//
//  SimpleAnimalModel.swift
//  uppgift-5
//
//  Created by Hendrik on 2023-10-24.
//

import Vision
import Foundation
import UIKit

class MobileNetModel {
    // TODO The asset image set two is identified as an elephant in the preview of the model.
    // TODO However, the code here identifies a cat with the same elephant image.
    let debug = false
    
    func predictImage(imageset_name: String) -> String {
        var result: String = ""

        // Create an instance of the image classifier's wrapper class or return optional nil
        if let imageClassifierWrapper = try? SimpleAnimalNet(configuration: MLModelConfiguration()) {
            // Model size rgb: w, h, 3
            if let theimage = UIImage(named: imageset_name) {
                let theimageBuffer = buffer(from: theimage)!
                do {
                    let output = try imageClassifierWrapper.prediction(image: theimageBuffer)
                    result = output.classLabel + " probablity: "
                        + String(format: "%.1f", 100 * output.classLabelProbs[output.classLabel]!) + "%\n"
                        + "imageset: " + imageset_name + "\n"
                    if (debug) {
                        result += "Debug w and h: " + String(format: "%.1f", theimage.size.width) + " " + String(format: "%.1f", theimage.size.height) + "\n"
                        for (animal, probability) in output.classLabelProbs {
                            result += "Debug " + animal + ": " + String(format: "%.3f", probability) + "\n"
                        }
                    }
                } catch {
                    // Model prediction failure
                    result = "Exception imageClassifierWrapper.prediction"
                }
            } else {
                // Assets image set name not defined
                result = "Image set not found: " + imageset_name
            }
        } else {
            // Model size rgb: out of model specification
            result = "Model not created: MobileNet"
        }
        return(result)
    }
    
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
}
