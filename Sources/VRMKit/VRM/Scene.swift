//
//  Scene.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180908.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#scene

extension GLTF {
    struct Scene: Codable {
        let nodes: [Int]?
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?
    }
}
