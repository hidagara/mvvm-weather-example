//
//  Array+Filter.swift
//  mvvm-weather-example
//
//  Created by Roman Guseynov on 04.12.2019.
//  Copyright © 2019 Roman Guseynov. All rights reserved.
//

import Foundation
public extension Array where Element: Hashable {
    static func removeDuplicates(_ elements: [Element]) -> [Element] {
        var seen = Set<Element>()
        return elements.filter {
            seen.insert($0).inserted
        }
    }
}
