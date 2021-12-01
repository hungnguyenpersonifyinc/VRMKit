//
//  BufferView.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#bufferview

extension GLTF {
    struct BufferView: Codable {
        let buffer: Int
        let _byteOffset: Int?
        var byteOffset: Int { return _byteOffset ?? 0 }
        let byteLength: Int
        let byteStride: Int?
        let target: Int?
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?
        private enum CodingKeys: String, CodingKey {
            case buffer
            case _byteOffset = "byteOffset"
            case byteLength
            case byteStride
            case target
            case name
            case extensions
            case extras
        }
    }
}
