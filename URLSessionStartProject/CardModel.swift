//
//  Model.swift
//  URLSessionStartProject
//
//  Created by Alexey Pavlov on 29/11/21.
//

import Foundation
import FileProvider

struct Card: Codable {
    let cards: [CardModel]
}

struct CardModel: Codable {
    let name: String?
    let type: String?
    let subtypes: String?
    let rarity: String?
    let power: String?
}
