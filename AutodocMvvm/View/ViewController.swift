//
//  ViewController.swift
//  AutodocMvvm
//
//  Created by Sergei Kovalev on 16.08.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var TableView: UITableView!
    
    
    private var news = Welcome()
    private let vm = NewsViewModel()
    private let input: PassthroughSubject<NewsViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bind()
        input.send(.viewDidLoad)
    }

    
    private func bind() {
        
        
        
        let output = vm.transform(input: input.eraseToAnyPublisher())
        output
          .receive(on: DispatchQueue.main)
          .sink { [weak self] event in
          switch event {
          case .fetchNewsDidSucceed(let news):
              self?.updateUI(with: news)
              self?.label.text = String(news.totalCount!)
          case .fetchNewsDidFail(let error):
              self?.errorr(with: error)
          }
        }.store(in: &cancellables)
        
    }
    
    
    private func errorr(with error: Error) {
        print("error\(error)")
    }
    
    
    private func updateUI(with news: Welcome) {

        self.TableView.delegate = self
        self.TableView.dataSource = self
        self.news = news
        
            self.TableView.reloadData()
        
    }
    

}

extension ViewController {
    @IBAction func unwindToNews(unwindSegue: UIStoryboardSegue) {
        
    }
}



extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Show" else {return}
        
        let navController = segue.destination as! UINavigationController
        
       let newsViewController = navController.topViewController as! DetailViewController
        guard let newIndexPath = TableView.indexPathForSelectedRow else {return}
        let selectednews: News = news.news![newIndexPath.row]
       newsViewController.news = selectednews
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.news!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        comfigureCell(cell, forCategoryAt: indexPath)

        return cell
    }
    
    func comfigureCell(_ cell: UITableViewCell, forCategoryAt indexPath: IndexPath) {
        let news = news.news![indexPath.row]
        cell.textLabel?.text = news.title!
    }
    
    
    
}





