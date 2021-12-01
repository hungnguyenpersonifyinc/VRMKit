//
//  VRMLoader.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180911.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation
import SceneKit

class VRMLoader {
    init() {}

    func load(named: String) throws -> VRM {
        guard let url = Bundle.main.url(forResource: named, withExtension: nil) else {
            throw URLError(.fileDoesNotExist)
        }
        return try load(withURL: url)
    }

    func load(withURL url: URL) throws -> VRM {
        let data = try Data(contentsOf: url)
        return try load(withData: data)
    }

    func load(withData data: Data) throws -> VRM {
        return try VRM(data: data)
    }
}
