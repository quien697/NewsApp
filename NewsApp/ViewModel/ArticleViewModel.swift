//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Quien on 2023-08-30.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: Article item ViewModel
struct ArticleViewModel {
  let article: Article
  
  init(_ article: Article) {
    self.article = article
  }
}

extension ArticleViewModel {
  var title: Observable<String> {
    return Observable.just(article.title)
  }
  var description: Observable<String> {
    return Observable<String>.just(article.description ?? "")
  }
}

// MARK: Article List ViewModel
struct ArticleListViewModel {
  let articleVM: [ArticleViewModel]
}

extension ArticleListViewModel {
  init(_ articles: [Article]) {
    self.articleVM = articles.compactMap(ArticleViewModel.init)
  }
}

extension ArticleListViewModel {
  func articleAt(_ index: Int) -> ArticleViewModel {
    return self.articleVM[index]
  }
}
