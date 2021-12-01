//
//  UIImage+GLTF.swift
//  VRMSceneKit
//
//  Created by Tatsuya Tanaka on 20180911.
//  Copyright © 2018年 tattn. All rights reserved.
//

#if os(iOS)
import UIKit

typealias GLTImage = UIImage
typealias GLTColor = UIColor
extension UIImage {
    static func create(image: GLTF.Image, relativeTo rootDirectory: URL?, loader: VRMSceneLoader) throws -> GLTImage {
        let data: Data
        if let uri = image.uri {
            data = try Data(gltfUrlString: uri, relativeTo: rootDirectory)
        } else if let bufferViewIndex = image.bufferView {
            data = try loader.bufferView(withBufferViewIndex: bufferViewIndex).bufferView
        } else {
            throw VRMError._dataInconsistent("failed to load images")
        }
        
        guard let uiImage = UIImage(data: data) else {
            throw VRMError._dataInconsistent("failed to load images")
        }
        return uiImage
    }
}

#else
import AppKit

typealias GLTImage = NSImage
typealias GLTColor = NSColor
extension NSImage {
    static func create(image: GLTF.Image, relativeTo rootDirectory: URL?, loader: VRMSceneLoader) throws -> GLTImage {
        let data: Data
        if let uri = image.uri {
            data = try Data(gltfUrlString: uri, relativeTo: rootDirectory)
        } else if let bufferViewIndex = image.bufferView {
            data = try loader.bufferView(withBufferViewIndex: bufferViewIndex).bufferView
        } else {
            throw VRMError._dataInconsistent("failed to load images")
        }
        
        guard let nsImage = GLTImage(data: data) else {
            throw VRMError._dataInconsistent("failed to load images")
        }
        
        return nsImage
    }
    
    var cgImage: CGImage? {
        let imageData = self.tiffRepresentation!
        let source = CGImageSourceCreateWithData(imageData as CFData, nil).unsafelyUnwrapped
        let maskRef = CGImageSourceCreateImageAtIndex(source, Int(0), nil)
        return maskRef.unsafelyUnwrapped
    }
}
#endif
