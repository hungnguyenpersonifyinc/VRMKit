//
//  GLTF.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180908.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

struct GLTF: Codable {
    let extensionsUsed: [String]?
    let extensionsRequired: [String]?
    let accessors: [Accessor]?
    let animations: [Animation]?
    let asset: Asset
    let buffers: [Buffer]?
    let bufferViews: [BufferView]?
    let cameras: [Camera]?
    let images: [Image]?
    let materials: [Material]?
    let meshes: [Mesh]?
    let nodes: [Node]?
    let samplers: [Sampler]?
    let _scene: Int?
    var scene: Int { return _scene ?? 0 }
    let scenes: [Scene]?
    let skins: [Skin]?
    let textures: [Texture]?
    let extensions: CodableAny?
    let extras: CodableAny?
    private enum CodingKeys: String, CodingKey {
        case extensionsUsed
        case extensionsRequired
        case accessors
        case animations
        case asset
        case buffers
        case bufferViews
        case cameras
        case images
        case materials
        case meshes
        case nodes
        case samplers
        case _scene = "scene"
        case scenes
        case skins
        case textures
        case extensions
        case extras
    }
}

extension GLTF {
    enum Version: UInt32 {
        case two = 2
    }
}
