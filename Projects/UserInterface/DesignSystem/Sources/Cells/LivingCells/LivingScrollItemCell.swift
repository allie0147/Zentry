//
//  LivingScrollItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct LivingScrollItemCell: View {
    private let imageURL: String
    private let title: String
    private let subtitle: String

    public init(_ title: String, subtitle: String, imageURL: String) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CachedAsyncImage(
                url: URL(string: imageURL)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.zetry(.grayScale(.gray2))
                }
            }
            .frame(width: 180, height: 250)
            .background(Color.zetry(.grayScale(.gray2)))
            .cornerRadius(4)

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .fontStyle(.subtitle2)
                Text(subtitle)
                    .fontStyle(.label2)
            }
        }
        .frame(width: 180)
    }
}
