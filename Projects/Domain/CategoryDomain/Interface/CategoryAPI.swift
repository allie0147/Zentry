//
//  CategoryAPI.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface

public enum CategoryAPI {
    case fetchItems(category: String)
    case fetchAllItems
}

extension CategoryAPI: TargetType {
    public var endPoint: EndPoint {
        .products
    }

    public var query: [String: Any]? {
        switch self {
        case .fetchItems(let category):
            return ["category": category]
        default:
            return nil
        }
    }
}
