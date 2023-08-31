//
//  ArticleTableViewController.swift
//  NewsApp
//
//  Created by Quien on 2023-08-30.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleTableViewController: UITableViewController {
  
  private let disposeBag = DisposeBag()
  private var articleListVM: ArticleListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchNews()
  }
  
  private func fetchNews() {
    let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=1442516164c24e12beb556892d94cfad")!)
    
    URLRequest.load(resource: resource)
      .subscribe(
        onNext: { articleResponse in
          let articles = articleResponse.articles
          self.articleListVM = ArticleListViewModel(articles)
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
      )
      .disposed(by: disposeBag)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articleListVM == nil ? 0 : articleListVM.articleVM.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
    let articleVM = self.articleListVM.articleAt(indexPath.row)
    articleVM.title
      .asDriver(onErrorJustReturn: "title error")
      .drive(cell.titleLabel.rx.text)
      .disposed(by: disposeBag)
    articleVM.description
      .asDriver(onErrorJustReturn: "description error")
      .drive(cell.descriptionLabel.rx.text)
      .disposed(by: disposeBag)
    return cell
  }
  
}

