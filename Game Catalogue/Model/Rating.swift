//
//  Rating.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import Foundation

struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}
