//
//  ProductDetailView.swift
//  ProductDetailFeature
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import DesignSystem
import ProductDomainInterface
import SwiftUI

public struct ProductDetailView: View {
    public let store: StoreOf<ProductDetailStore>

    public init(store: StoreOf<ProductDetailStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            let product = viewStore.item

            VStack(alignment: .leading, spacing: 0) {
                ObservableScrollView(
                    scrollOffset: viewStore.binding(
                        get: \.scrollViewOffsetY,
                        send: ProductDetailStore.Action.scrollOffsetYChanged
                    )
                ) { _ in
                    GeometryReader { proxy in
                        ZStack(alignment: .top) {
                            productImageView(
                                url: product.imageURL,
                                imageHeight: viewStore.imageHeight,
                                proxy: proxy
                            )

                            detailChips(
                                recyclable: product.recyclable,
                                isTrash: product.isTrash,
                                category: product.category,
                                imageHeight: viewStore.imageHeight
                            )
                        }
                    }
                    .frame(height: viewStore.imageHeight)
                    detailContentView(viewStore: viewStore)
                        .offset(y: -40)
                }
            }
            .background(.regularMaterial)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(product.title)
                        .fontStyle(.subtitle2)
                        .opacity(viewStore.scrollViewOffsetY > 300 ? 1 : 0)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewStore.send(.pop)
                    } label: {
                        ZetryIcon(DesignSystemAsset.Icons.chevronLeft)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewStore.send(.popToRoot)
                    } label: {
                        ZetryIcon(DesignSystemAsset.Icons.house)
                    }
                }
            }
            .onLoad {
                viewStore.send(.onLoad)
            }
        }
    }

    @ViewBuilder
    func productImageView(
        url: String,
        imageHeight: CGFloat,
        proxy: GeometryProxy
    ) -> some View {
        let offsetY = proxy.frame(in: .global).minY > 0 ? -proxy.frame(in: .global).minY : 0
        let height = proxy.frame(in: .global).minY > 0 ?imageHeight + proxy.frame(in: .global).minY : imageHeight

        Image
            .load(url)
            .offset(y: offsetY)
            .frame(height: height)
    }

    @ViewBuilder
    private func detailChips(
        recyclable: Bool,
        isTrash: Bool,
        category: String,
        imageHeight: CGFloat
    ) -> some View {
        HStack(spacing: 8) {
            DetailChip(
                text: recyclable ? "재활용 가능" : "재활용 불가능",
                icon: recyclable ? DesignSystemAsset.Icons.arrow3Trianglepath : nil
            )
            if isTrash {
                DetailChip(text: "일반 쓰레기")
            }
            DetailChip(text: category)
            Spacer()
        }
        .padding(.horizontal, 28)
        .offset(y: imageHeight - 75)
    }

    @ViewBuilder
    func detailContentView(viewStore: ViewStoreOf<ProductDetailStore>) -> some View {
        let product = viewStore.item
        let recommendItems = viewStore.recommendedItems
        VStack(alignment: .leading, spacing: 15) {
            Text(product.title)
                .fontStyle(.headline1)
                .padding(.leading, 28)

            Divider(color: .primary(.black), opacity: 0.05)

            Text("버리는 방법")
                .fontStyle(.subtitle1)
                .padding(.leading, 28)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(product.description, id: \.self) { description in
                    BulletText(description)
                }
                HStack(alignment: .top, spacing: 8) {
                    ZetryIcon(DesignSystemAsset.Icons.exclamationmarkCircle,
                              foregroundColor: .primary(.primary))
                    Text("마우스는 폐가전 무상방문수거 서비스를 통해 컴퓨터를 배출할 때 배출할 수 있어요.")
                        .fontStyle(.body2, foregroundColor: .grayScale(.gray7))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 9)

            Divider(color: .grayScale(.gray2))

            VStack(alignment: .leading) {
                Text("이런 쓰레기는 어떠세요?")
                    .fontStyle(.subtitle2)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(recommendItems, id: \.self) {
                            CategoryItemCell($0.title, imageUrl: $0.imageURL, size: 72) {}
                        }
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.top, 13)
        }
        .padding(.top, 20)
        .background(.regularMaterial)
        .border(width: 1, edges: [.top], color: .white.opacity(0.8))
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}
