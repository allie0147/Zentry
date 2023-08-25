//
//  ZetrySecondaryButtonStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/25.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct ZetrySecondaryButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .fontStyle(.body1, foregroundColor: .grayScale(.gray6))
            .padding(10)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.zetry(.grayScale(.gray1)))
            }
    }
}

public extension ButtonStyle where Self == ZetrySecondaryButtonStyle {
    static var secondary: ZetrySecondaryButtonStyle {
        self.init()
    }
}
