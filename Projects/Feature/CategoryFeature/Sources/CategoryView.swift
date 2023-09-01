//
//  CategoryView.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import DesignSystem
import SwiftUI

public struct CategoryView: View {
    public let store: StoreOf<CategoryStore>

    public init(store: StoreOf<CategoryStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(spacing: 0) {
                HStack {
                    Text("카테고리")
                        .fontStyle(.subtitle2)
                }
                .frame(maxWidth: .infinity, maxHeight: 38)
                .overlay(alignment: .trailing) {
                    Button {
                        viewStore.send(.didTapSearchButton)
                    } label: {
                        ZetryIcon(DesignSystemAsset.Icons.magnifyingglass, size: .larger)
                            .padding(.trailing, 16)
                    }
                }

                SegmentedPicker(
                    viewStore.$selectedSegment,
                    segments: CategoryStore.CategorySegementedTab.allCases,
                    paddingHorizontal: 23.5
                )
//                SegmentedPicker(
//                    viewStore.binding(
//                        get: { $0.selectedSegment },
//                        send: CategoryStore.Action.selectedSegment
//                    ),
//                    segments: CategoryStore.CategorySegementedTab.allCases,
//                    paddingHorizontal: 23.5
//                )

                GeometryReader { proxy in
                    HStack(spacing: 0) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(Category.allCases, id: \.self) {
                                    categoryView($0, selected: $0 == viewStore.selectedCategory)
                                        .onTapGesture {
                                            viewStore.selectedCategory = $0
                                        }
                                }
                            }
                        }
                        .frame(maxWidth: proxy.size.width * 0.35)

                        ScrollView {
                            if viewStore.selectedSegment == .recyclable {
                                Text("recycle")
                            } else {
                                Text("non-recycle")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.zetry(.grayScale(.gray0)))
            }
        }
    }

    @ViewBuilder
    private func categoryView(_ category: Category, selected: Bool) -> some View {
        Text(category.rawValue)
            .fontStyle(
                selected ? .subtitle3 : .body2,
                foregroundColor: selected ? .grayScale(.gray12) : .grayScale(.gray5)
            )
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 56)
            .contentShape(Rectangle())
            .background(Color.white)
    }
}
