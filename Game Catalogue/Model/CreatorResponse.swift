//
//  CreatorResponse.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import Foundation

struct CreatorResponse: Codable {
    let count: Int
    let next: String
    let results: [Creator]
}

struct Creator: Codable {
   let id: Int
   let name: String
   let slug: String
   let image: String
   let image_background: String
   let games_count: Int
   let positions: [GamePos]
}


struct GamePos: Codable {
    let id: Int
    let slug: String
    let name: String
    let added: Int?
}
