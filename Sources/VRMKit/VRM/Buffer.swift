//
//  Buffer.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#buffer

extension GLTF {
    struct Buffer: Codable {
        let uri: String?
        let byteLength: Int
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?
    }
}
