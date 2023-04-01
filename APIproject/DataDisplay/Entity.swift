//
//  Entity.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit

struct Documents: Codable, Hashable {
    let type: String
    let number: String
    let date: String
    let status: Bool
    let delete: Bool
    let pred: String
}

struct CreateDoc: Codable {
    let number: String
}

struct DataForDisplay {
    var type: String
    var number: String
    var date: String
    var status: String
    var image: UIImage
}

