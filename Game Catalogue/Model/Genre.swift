//
//  Genre.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
    let slug: String
    let games_count: Int
    let image_background: String
    let domain: String?
}
