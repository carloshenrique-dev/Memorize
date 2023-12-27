//
//  Array+Only.swift
//  Memorize
//
//  Created by Carlos Henrique on 27/12/23.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
