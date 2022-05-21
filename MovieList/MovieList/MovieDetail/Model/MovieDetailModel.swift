//
//  MovieDetailModel.swift
//  MovieList
//
//  Created by Yuhao on 2022/5/11.
//

import Foundation

struct MovieDetailModel: Codable {
    let name: String
    let score: String
    let image: String
    let category: String
    let youtube: String
    let desc: String
}

struct MovieResponseModel: Codable {
    let list: [MovieDetailModel]
}
