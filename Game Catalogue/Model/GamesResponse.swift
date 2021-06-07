//
//  GamesResponse.swift
//  Game Catalogue
//
//  Created by Edo Lorenza on 07/06/21.
//

import Foundation

import Foundation

struct GamesResponse: Codable {
    let results: [Games]
}

struct Games: Codable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let background_image: String
    let rating: Double
    let ratings: [Rating]
    let ratings_count: Int
    let added: Int
    let metacritic: Int
    let playtime: Int
    let suggestions_count: Int
    let updated: String
    let reviews_count: Int
    let saturated_color: String
    let dominant_color: String
    let genres: [Genre]
    let short_screenshots: [ShortScreenshot]

}
