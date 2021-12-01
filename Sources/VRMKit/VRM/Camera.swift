//
//  Camera.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180908.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#camera

extension GLTF {
    struct Camera: Codable {
        let orthographic: Orthographic?
        let perspective: Perspective?
        let type: Type
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?

        struct Orthographic: Codable {
            let xmag: Float
            let ymag: Float
            let zfar: Float
            let znear: Float
            let extensions: CodableAny?
            let extras: CodableAny?
        }

        struct Perspective: Codable {
            let aspectRatio: Float?
            let yfov: Float
            let zfar: Float?
            let znear: Float
            let extensions: CodableAny?
            let extras: CodableAny?
        }

        enum `Type`: String, Codable {
            case perspective
            case orthographic
        }
    }
}
