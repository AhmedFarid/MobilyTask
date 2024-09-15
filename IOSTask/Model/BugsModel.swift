//
//  BugsModel.swift
//  IOSTask
//
//  Created by Farido on 15/09/2024.
//

import Foundation

struct BugsModel: Identifiable {
    var id = UUID().uuidString
    var bugTitle: String
    var bugDesc: String
    var bugImage: Data
}
