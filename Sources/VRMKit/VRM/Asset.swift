//
//  Asset.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#asset-1

extension GLTF {
    struct Asset: Codable {
        let copyright: String?
        let generator: String?
        let version: String
        let minVersion: String?
        let extensions: CodableAny?
        let extras: CodableAny?
    }
}
