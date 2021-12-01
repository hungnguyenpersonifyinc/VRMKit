//
//  Vector4.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180908.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

extension GLTF {
    struct Vector4: Codable {
        let x, y, z, w: Float

        static var zero: Vector4 {
            return .init(x: 0, y: 0, z: 0, w: 0)
        }
    }
}

extension GLTF.Vector4 {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        x = try container.decode(Float.self)
        y = try container.decode(Float.self)
        z = try container.decode(Float.self)
        w = try container.decode(Float.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(x)
        try container.encode(y)
        try container.encode(z)
        try container.encode(w)
    }
}
