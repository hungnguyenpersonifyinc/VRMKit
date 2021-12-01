//
//  simd+.swift
//  VRMSceneKit
//
//  Created by Tomoya Hirano on 2020/02/16.
//  Copyright © 2020 tattn. All rights reserved.
//

import simd
import SceneKit

extension SIMD3 where Scalar == Float {
    var normalized: SIMD3 {
        simd_normalize(self)
    }
    
    var length: Scalar {
        simd_length(self)
    }
    
    var length_squared: Scalar {
        simd_length_squared(self)
    }
}

extension simd_float4x4 {
    func multiplyPoint(_ v: SIMD3<Float>) -> SIMD3<Float> {
        let scn = SCNMatrix4(self)
        var vector3: SIMD3<Float> = SIMD3<Float>()
        let vx = CGFloat(v.x)
        let vy = CGFloat(v.y)
        let vz = CGFloat(v.z)
        vector3.x = Float((scn.m11 * vx + scn.m21 * vy + scn.m31 * vz) + scn.m41)
        vector3.y = Float((scn.m12 * vx + scn.m22 * vy + scn.m32 * vz) + scn.m42)
        vector3.z = Float((scn.m13 * vx + scn.m23 * vy + scn.m33 * vz) + scn.m43)
        let num: Float = 1.0 / Float((scn.m14 * vx + scn.m24 * vy + scn.m34 * vz) + scn.m44)
        vector3.x *= num
        vector3.y *= num
        vector3.z *= num
        return vector3
    }
}

extension simd_quatf {
    static func * (_ left: simd_quatf, _ right: SIMD3<Float>) -> SIMD3<Float> {
        simd_act(left, right)
    }
}
var quart_identity_float = simd_quatf(matrix_identity_float4x4)
