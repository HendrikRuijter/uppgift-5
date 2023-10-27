//
//  SimpleAnimalModel.swift
//  uppgift-5
//
//  Created by Hendrik on 2023-10-24.
//

import CoreML
import UIKit

class Model {
    // TODO The model SimpleAnimalNet is unbalanced and there are too few images in the data set
    let debug = false
    
    func predictImage(imageset_name: String) -> String {
        var result: String = ""
        
        if (imageset_name == "") {
            return result
        }
        
        if let imageClassifierWrapper = try? SimpleAnimalNet(configuration: MLModelConfiguration()) {
            if let image = UIImage(named: imageset_name) {
                if let imageCvp = tocvp(from: image) {
                    if (debug) {
                        for _ in (0..<10) {
                            if let output = try? imageClassifierWrapper.prediction(image: imageCvp) {
                                var tst = "Debug "
                                for (animal, probability) in output.classLabelProbs {
                                    tst += animal + ": " + String(format: "%.3f", probability) + " / "
                                }
                                print(tst)
                            } else {
                                result = "Exception imageClassifierWrapper.prediction"
                            }
                        }
                        result = "Check console print messages"
                    } else {
                        if let output = try? imageClassifierWrapper.prediction(image: imageCvp) {
                            result = output.classLabel + " probablity: "
                            + String(format: "%.1f", 100 * output.classLabelProbs[output.classLabel]!)
                            + "%\nimageset: " + imageset_name + "\n"
                        } else {
                            result = "Exception imageClassifierWrapper.prediction"
                        }
                    }
                } else {
                    result = "CVPixelBuffer not created."
                }
            } else {
                result = "Image set not found: " + imageset_name
            }
        } else {
            result = "Model not created."
        }
        return result
    }
    
    func tocvp(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        return pixelBuffer
    }
}
