//
//  NewsViewModel.swift
//  AutodocMvvm
//
//  Created by Sergei Kovalev on 16.08.2022.
//

import Foundation
import Combine
import UIKit



class NewsViewModel {
    
    enum Input {
      case viewDidLoad
    }
    
    enum Output {
      case fetchNewsDidFail(error: Error)
      case fetchNewsDidSucceed(news: Welcome)
    }
    
    
    
    
    
    private let newsService: ServiceProtocol
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(newsService: ServiceProtocol = Sevice()) {
      self.newsService = newsService
    }
    
    var reloadTableView: (() -> Void)?
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
      input.sink { [weak self] event in
        switch event {
        case .viewDidLoad:
          self?.handleGetNews()
        }
      }.store(in: &cancellables)
      return output.eraseToAnyPublisher()
    }
    
    private func handleGetNews() {
        newsService.getNews().sink { [weak self] completion in
        if case .failure(let error) = completion {
          self?.output.send(.fetchNewsDidFail(error: error))
        }
      } receiveValue: { [weak self] news in
          self?.output.send(.fetchNewsDidSucceed(news: news))
      }.store(in: &cancellables)
    }

    
}



