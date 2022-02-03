//
//  CVPixelBuffer+CIImage.swift
//  iOS-Depth-Sampler
//
//  Created by Shuichi Tsutsumi on 2018/09/12.
//  Copyright © 2018 Shuichi Tsutsumi. All rights reserved.
//

import CoreVideo
import CoreImage

extension CVPixelBuffer {
    func transformedImage(targetSize: CGSize, rotationAngle: CGFloat) -> CIImage? {
        let image = CIImage(cvPixelBuffer: self, options: [:])
        let scaleFactor = Float(targetSize.width) / Float(image.extent.width)
        return image.transformed(by: CGAffineTransform(rotationAngle: rotationAngle)).applyingFilter("CIBicubicScaleTransform", parameters: ["inputScale": scaleFactor])
    }
    // TODO: 改变像素的方式，还原深度图，
    func transformToDepthMap()->CIImage{
        CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags.init(rawValue: 0))
        
        let p = CVPixelBufferGetBaseAddress(self)
        //指针操作
        let width = CVPixelBufferGetWidth(self)
        let height = CVPixelBufferGetHeight(self)
        let format = CVPixelBufferGetPixelFormatType(self)
        print("format:\(format),width:\(width),heighy:\(height)")
//        for i in 0...(width-1) {
//            for j in 0...(height - 1){
//                let v:Float32 = p?.load(fromByteOffset: (i * width + j)*4, as: Float32.self) ?? 66
//                print("\(i),\(j),\(v)")
//            }
//        }
        CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags.init(rawValue: 0))
        
        
        return CIImage.init(cvPixelBuffer: self).oriented(.right)
    }
    
    func printSelf(){
        
    }
}
