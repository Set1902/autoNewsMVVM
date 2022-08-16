//
//  News.swift
//  AutodocMvvm
//
//  Created by Sergei Kovalev on 16.08.2022.
//

import Foundation

// MARK: - Welcome
class Welcome: Decodable {
    var news: [News]?
    var totalCount: Int?

    
}

// MARK: - News
class News: Decodable {
    var id: Int?
    var title, newsDescription, publishedDate, url: String?
    var fullURL: String?
    var titleImageURL: String?
    var categoryType: CategoryType?

    enum CodingKeys: String, CodingKey {
        case id, title
        case newsDescription = "description"
        case publishedDate, url
        case fullURL = "fullUrl"
        case titleImageURL = "titleImageUrl"
        case categoryType
    }

}

enum CategoryType: String, Codable {
    case автомобильныеНовости = "Автомобильные новости"
    case новостиКомпании = "Новости компании"
}
