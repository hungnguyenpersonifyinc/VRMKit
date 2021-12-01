//
//  Animation.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#animation

extension GLTF {
    struct Animation: Codable {
        let channels: [Channel]
        let samplers: [Sampler]
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?

        struct Channel: Codable {
            let sampler: Int
            let target: Target
            let extensions: CodableAny?
            let extras: CodableAny?

            struct Target: Codable {
                let node: Int?
                let path: String
                let extensions: CodableAny?
                let extras: CodableAny?
            }
        }

        struct Sampler: Codable {
            let input: Int
            let _interpolation: Interpolation?
            var interpolation: Interpolation { return _interpolation ?? .LINEAR }
            let output: Int
            let extensions: CodableAny?
            let extras: CodableAny?
            private enum CodingKeys: String, CodingKey {
                case input
                case _interpolation = "interpolation"
                case output
                case extensions
                case extras
            }

            enum Interpolation: String, Codable {
                case LINEAR
                case STEP
                case CUBICSPLINE
            }
        }
    }
}
