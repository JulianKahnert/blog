//
//  Date.swift
//  
//
//  Created by Julian Kahnert on 14.02.21.
//

import Foundation

extension Date {
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
}
