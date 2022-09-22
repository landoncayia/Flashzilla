//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Landon Cayia on 9/22/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
