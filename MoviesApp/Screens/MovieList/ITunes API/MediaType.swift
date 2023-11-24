//
//  MediaType.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//

import Foundation

public protocol MediaType {
    associatedtype Entity: RawRepresentable where Entity.RawValue == String
    associatedtype Attribute: RawRepresentable where Attribute.RawValue == String
}
