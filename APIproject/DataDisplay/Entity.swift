//
//  Entity.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import Foundation

struct Documents: Codable {
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

