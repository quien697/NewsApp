//
//  Article.swift
//  NewsApp
//
//  Created by Quien on 2023-08-30.
//

import Foundation

struct Article: Decodable {
  let title: String
  let description: String?
}

struct ArticleResponse: Decodable {
  let articles: [Article]
}
