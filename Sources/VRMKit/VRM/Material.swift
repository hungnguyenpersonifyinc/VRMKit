//
//  Material.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

// https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#material

extension GLTF {
    struct Material: Codable {
        let name: String?
        let extensions: CodableAny?
        let extras: CodableAny?
        let pbrMetallicRoughness: PbrMetallicRoughness?
        let normalTexture: NormalTextureInfo?
        let occlusionTexture: OcclusionTextureInfo?
        let emissiveTexture: TextureInfo?
        let _emissiveFactor: Color3?
        var emissiveFactor: Color3 { return _emissiveFactor ?? .black }
        let _alphaMode: AlphaMode?
        var alphaMode: AlphaMode { return _alphaMode ?? .OPAQUE }
        let _alphaCutoff: Float?
        var alphaCutoff: Float { return _alphaCutoff ?? 0.5 }
        let _doubleSided: Bool?
        var doubleSided: Bool { return _doubleSided ?? false }
        private enum CodingKeys: String, CodingKey {
            case name
            case extensions
            case extras
            case pbrMetallicRoughness
            case normalTexture
            case occlusionTexture
            case emissiveTexture
            case _emissiveFactor = "emissiveFactor"
            case _alphaMode = "alphaMode"
            case _alphaCutoff = "alphaCutoff"
            case _doubleSided = "doubleSided"
        }

        struct PbrMetallicRoughness: Codable {
            let _baseColorFactor: Color4?
            var baseColorFactor: Color4 { return _baseColorFactor ?? .init(r: 0, g: 0, b: 0, a: 0) }
            let baseColorTexture: TextureInfo?
            let _metallicFactor: Float?
            var metallicFactor: Float { return _metallicFactor ?? 1 }
            let _roughnessFactor: Float?
            var roughnessFactor: Float { return _roughnessFactor ?? 1 }
            let metallicRoughnessTexture: TextureInfo?
            let extensions: CodableAny?
            let extras: CodableAny?
            private enum CodingKeys: String, CodingKey {
                case _baseColorFactor = "baseColorFactor"
                case baseColorTexture
                case _metallicFactor = "metallicFactor"
                case _roughnessFactor = "roughnessFactor"
                case metallicRoughnessTexture
                case extensions
                case extras
            }
        }

        struct NormalTextureInfo: Codable {
            let index: Int
            let _texCoord: Int?
            var texCoord: Int { return _texCoord ?? 0 }
            let _scale: Float?
            var scale: Float { return _scale ?? 1 }
            let extensions: CodableAny?
            let extras: CodableAny?
            private enum CodingKeys: String, CodingKey {
                case index
                case _texCoord = "texCoord"
                case _scale = "scale"
                case extensions
                case extras
            }
        }

        struct OcclusionTextureInfo: Codable {
            let index: Int
            let _texCoord: Int?
            var texCoord: Int { return _texCoord ?? 0 }
            let _strength: Float?
            var strength: Float { return _strength ?? 1 }
            let extensions: CodableAny?
            let extras: CodableAny?
            private enum CodingKeys: String, CodingKey {
                case index
                case _texCoord = "texCoord"
                case _strength = "strength"
                case extensions
                case extras
            }
        }

        enum AlphaMode: String, Codable {
            case OPAQUE
            case MASK
            case BLEND
        }
    }
}
