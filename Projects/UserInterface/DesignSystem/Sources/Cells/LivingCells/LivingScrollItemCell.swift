//
//  LivingScrollItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
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
            Image
                .load(imageURL, width: 180, height: 250)
                .background(Color.zetry(.grayScale(.gray3)))
                .cornerRadius(4)

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .lineLimit(1)
                    .fontStyle(.subtitle3)
                
                MultilineText(subtitle, lineLimit: 2, font: .body3)
            }
            Spacer()
        }
        .frame(width: 186)
    }
}
