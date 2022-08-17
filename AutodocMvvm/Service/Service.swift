//
//  Service.swift
//  AutodocMvvm
//
//  Created by Sergei Kovalev on 16.08.2022.
//

import Foundation
import Combine
import UIKit
protocol ServiceProtocol {
    func getNews() -> AnyPublisher<Welcome, Error>
}

class Sevice: ServiceProtocol {
    func getNews() -> AnyPublisher<Welcome, Error> {
      let url = URL(string: "https://webapi.autodoc.ru/api/news/1/15")
      return URLSession.shared.dataTaskPublisher(for: url!)
        .catch { error in
          return Fail(error: error).eraseToAnyPublisher()
        }.map({ $0.data })
        .decode(type: Welcome.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
    
    
    
    
}
