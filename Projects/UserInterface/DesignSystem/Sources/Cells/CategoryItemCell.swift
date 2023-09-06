//
//  CategoryItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/01.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct CategoryItemCell: View {
    private let title: String
    private let imageUrl: String
    private let size: CGFloat

    public init(_ title: String, size: CGFloat, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.size = size
    }

    public var body: some View {
        VStack(spacing: 8) {
            CachedAsyncImage(
                url: URL(string: imageUrl)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Color.zetry(.grayScale(.gray3))
                }
            }
            .background(Color.zetry(.grayScale(.gray2)))
            .cornerRadius(20)

            Text(title)
                .fontStyle(.body2)
        }
    }
}
