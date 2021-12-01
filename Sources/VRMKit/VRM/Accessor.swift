//
//  Accessor.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#accessor

extension GLTF {
    struct Accessor: Codable {
        let bufferView: Int?
        let _byteOffset: Int?
        var byteOffset: Int { return _byteOffset ?? 0 }
        let componentType: ComponentType
        let _normalized: Bool?
        var normalized: Bool { return _normalized ?? false }
        let count: Int
        let type: Type
        let max: [Float]?
        let min: [Float]?
        let sparse: Sparse?
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?

        private enum CodingKeys: String, CodingKey {
            case bufferView
            case _byteOffset = "byteOffset"
            case componentType
            case _normalized = "normalized"
            case count
            case type
            case max
            case min
            case sparse
            case name
            case extensions
            case extras
        }
    }
}

extension GLTF.Accessor {
    enum ComponentType: Int, Codable {
        case byte = 5120
        case unsignedByte = 5121
        case short = 5122
        case unsignedShort = 5123
        case unsignedInt = 5125
        case float = 5126
    }

    enum `Type`: String, Codable {
        case SCALAR
        case VEC2
        case VEC3
        case VEC4
        case MAT2
        case MAT3
        case MAT4
    }

    struct Sparse: Codable {
        let count: Int
        let indices: Indices
        let values: Values
        let extensions: CodableAny?
        let extras: CodableAny?

        struct Indices: Codable {
            let bufferView: Int
            let _byteOffset: Int?
            var byteOffset: Int { return _byteOffset ?? 0 }
            let componentType: ComponentType
            let extensions: CodableAny?
            let extras: CodableAny?
            private enum CodingKeys: String, CodingKey {
                case bufferView
                case _byteOffset = "byteOffset"
                case componentType
                case extensions
                case extras
            }
        }

        struct Values: Codable {
            let bufferView: Int
            let _byteOffset: Int?
            var byteOffset: Int { return _byteOffset ?? 0 }
            let extensions: CodableAny?
            let extras: CodableAny?
            private enum CodingKeys: String, CodingKey {
                case bufferView
                case _byteOffset = "byteOffset"
                case extensions
                case extras
            }
        }
    }
}
