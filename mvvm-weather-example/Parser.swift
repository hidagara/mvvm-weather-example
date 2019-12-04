//
//  Parser.swift
//  mvvm-weather-example
//
//  Created by Roman Guseynov on 04.12.2019.
//  Copyright © 2019 Roman Guseynov. All rights reserved.
//

import Foundation
import Combine

func decode<T: Decodable> (_ data: Data) -> AnyPublisher<T, WeatherError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
            .mapError{ error in
                .parsing(description: error.localizedDescription)
        }.eraseToAnyPublisher()
}
