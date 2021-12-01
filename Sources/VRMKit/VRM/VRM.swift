//
//  VRM.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

struct VRM {
    let gltf: BinaryGLTF
    let meta: Meta
    let version: String?
    let materialProperties: [MaterialProperty]
    let humanoid: Humanoid
    let blendShapeMaster: BlendShapeMaster
    let firstPerson: FirstPerson
    let secondaryAnimation: SecondaryAnimation

    let materialPropertyNameMap: [String: MaterialProperty]

    init(data: Data) throws {
        gltf = try BinaryGLTF(data: data)

        let rawExtensions = try gltf.jsonData.extensions ??? .keyNotFound("extensions")
        let extensions = try rawExtensions.value as? [String: [String: Any]] ??? .dataInconsistent("extension type mismatch")
        let vrm = try extensions["VRM"] ??? .keyNotFound("VRM")

        let decoder = DictionaryDecoder()
        meta = try decoder.decode(Meta.self, from: try vrm["meta"] ??? .keyNotFound("meta"))
        version = vrm["version"] as? String
        materialProperties = try decoder.decode([MaterialProperty].self, from: try vrm["materialProperties"] ??? .keyNotFound("materialProperties"))
        humanoid = try decoder.decode(Humanoid.self, from: try vrm["humanoid"] ??? .keyNotFound("humanoid"))
        blendShapeMaster = try decoder.decode(BlendShapeMaster.self, from: try vrm["blendShapeMaster"] ??? .keyNotFound("blendShapeMaster"))
        firstPerson = try decoder.decode(FirstPerson.self, from: try vrm["firstPerson"] ??? .keyNotFound("firstPerson"))
        secondaryAnimation = try decoder.decode(SecondaryAnimation.self, from: try vrm["secondaryAnimation"] ??? .keyNotFound("secondaryAnimation"))

        materialPropertyNameMap = materialProperties.reduce(into: [:]) { $0[$1.name] = $1 }
    }
}

extension VRM {
    struct Meta: Codable {
        let title: String?
        let author: String?
        let contactInformation: String?
        let reference: String?
        let texture: Int?
        let version: String?

        let allowedUserName: String?
        let violentUssageName: String?
        let sexualUssageName: String?
        let commercialUssageName: String?
        let otherPermissionUrl: String?

        let licenseName: String?
        let otherLicenseUrl: String?
    }

    struct MaterialProperty: Codable {
        let name: String
        let shader: String
        let renderQueue: Int
        let floatProperties: CodableAny
        let keywordMap: [String: Bool]
        let tagMap: [String: String]
        let textureProperties: [String: Int]
        let vectorProperties: CodableAny
    }

    struct Humanoid: Codable {
        let armStretch: Double
        let feetSpacing: Double
        let hasTranslationDoF: Bool
        let legStretch: Double
        let lowerArmTwist: Double
        let lowerLegTwist: Double
        let upperArmTwist: Double
        let upperLegTwist: Double
        let humanBones: [HumanBone]

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            armStretch = try decodeDouble(key: .armStretch, container: container)
            feetSpacing = try decodeDouble(key: .feetSpacing, container: container)
            hasTranslationDoF = try container.decode(Bool.self, forKey: .hasTranslationDoF)
            legStretch = try decodeDouble(key: .legStretch, container: container)
            lowerArmTwist = try decodeDouble(key: .lowerArmTwist, container: container)
            lowerLegTwist = try decodeDouble(key: .lowerLegTwist, container: container)
            upperArmTwist = try decodeDouble(key: .upperArmTwist, container: container)
            upperLegTwist = try decodeDouble(key: .upperLegTwist, container: container)
            humanBones = try container.decode([HumanBone].self, forKey: .humanBones)
        }

        struct HumanBone: Codable {
            let bone: String
            let node: Int
            let useDefaultValues: Bool
        }
    }

    struct BlendShapeMaster: Codable {
        let blendShapeGroups: [BlendShapeGroup]
        struct BlendShapeGroup: Codable {
            let binds: [Bind]?
            let materialValues: [MaterialValueBind]?
            let name: String
            let presetName: String
            let _isBinary: Bool?
            var isBinary: Bool { return _isBinary ?? false }
            private enum CodingKeys: String, CodingKey {
                case binds
                case materialValues
                case name
                case presetName
                case _isBinary = "isBinary"
            }
            struct Bind: Codable {
                let index: Int
                let mesh: Int
                let weight: Double

                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    index = try container.decode(Int.self, forKey: .index)
                    mesh = try container.decode(Int.self, forKey: .mesh)
                    weight = try decodeDouble(key: .weight, container: container)
                }
            }
            struct MaterialValueBind: Codable {
                let materialName: String
                let propertyName: String
                let targetValue: [Double]
            }
        }
    }

    struct FirstPerson: Codable {
        let firstPersonBone: Int
        let firstPersonBoneOffset: Vector3
        let meshAnnotations: [MeshAnnotation]
        let lookAtTypeName: LookAtType
        
        struct MeshAnnotation: Codable {
            let firstPersonFlag: String
            let mesh: Int
        }
        enum LookAtType: String, Codable {
            case none = "None"
            case bone = "Bone"
            case blendShape = "BlendShape"
        }
    }

    struct SecondaryAnimation: Codable {
        let boneGroups: [BoneGroup]
        let colliderGroups: [ColliderGroup]
        struct BoneGroup: Codable {
            let bones: [Int]
            let center: Int
            let colliderGroups: [Int]
            let comment: String?
            let dragForce: Double
            let gravityDir: Vector3
            let gravityPower: Double
            let hitRadius: Double
            let stiffiness: Double

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                bones = try container.decode([Int].self, forKey: .bones)
                center = try container.decode(Int.self, forKey: .center)
                colliderGroups = try container.decode([Int].self, forKey: .colliderGroups)
                comment = try? container.decode(String.self, forKey: .comment)
                dragForce = try decodeDouble(key: .dragForce, container: container)
                gravityDir = try container.decode(Vector3.self, forKey: .gravityDir)
                gravityPower = try decodeDouble(key: .gravityPower, container: container)
                hitRadius = try decodeDouble(key: .hitRadius, container: container)
                stiffiness = try decodeDouble(key: .stiffiness, container: container)
            }
        }
        
        struct ColliderGroup: Codable {
            let node: Int
            let colliders: [Collider]
            
            struct Collider: Codable {
                let offset: Vector3
                let radius: Double
            }
        }
    }

    struct Vector3: Codable {
        let x, y, z: Double
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            x = try decodeDouble(key: .x, container: container)
            y = try decodeDouble(key: .y, container: container)
            z = try decodeDouble(key: .z, container: container)
        }
    }
}

private func decodeDouble<T: CodingKey>(key: T, container: KeyedDecodingContainer<T>) throws -> Double {
    return try (try? container.decode(Double.self, forKey: key)) ?? Double(try container.decode(Int.self, forKey: key))
}
