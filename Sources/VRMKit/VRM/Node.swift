//
//  Node.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180908.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#node

extension GLTF {
    struct Node: Codable {
        let camera: Int?
        let children: [Int]?
        let skin: Int?
        let _matrix: Matrix?
        var matrix: Matrix {
            return self._matrix ?? .identity
        }
        let mesh: Int?
        let _rotation: Vector4?
        var rotation: Vector4 {
            return self._rotation ?? .zero
        }
        let _scale: Vector3?
        var scale: Vector3 {
            return self._scale ?? .one
        }
        let _translation: Vector3?
        var translation: Vector3 {
            return self._translation ?? .zero
        }
        let weights: [Float]?
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?

        private enum CodingKeys: String, CodingKey {
            case camera
            case children
            case skin
            case _matrix = "matrix"
            case mesh
            case _rotation = "rotation"
            case _scale = "scale"
            case _translation = "translation"
            case weights
            case name
            case extensions
            case extras
        }
    }
}
