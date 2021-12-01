//
//  Vector3.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180908.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

extension GLTF {
    struct Vector3: Codable {
        let x, y, z: Float

        static var zero: Vector3 {
            return .init(x: 0, y: 0, z: 0)
        }

        static var one: Vector3 {
            return .init(x: 1, y: 1, z: 1)
        }
    }
}

extension GLTF.Vector3 {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        x = try container.decode(Float.self)
        y = try container.decode(Float.self)
        z = try container.decode(Float.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(x)
        try container.encode(y)
        try container.encode(z)
    }
}
