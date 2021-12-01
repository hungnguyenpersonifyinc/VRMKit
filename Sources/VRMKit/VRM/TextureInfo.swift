//
//  TextureInfo.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#textureinfo

extension GLTF {
    struct TextureInfo: Codable {
        let index: Int
        let _texCoord: Int?
        var texCoord: Int { return _texCoord ?? 0 }
        let extensions: CodableAny?
        let extras: CodableAny?
        private enum CodingKeys: String, CodingKey {
            case index
            case _texCoord = "texCoord"
            case extensions
            case extras
        }
    }
}
