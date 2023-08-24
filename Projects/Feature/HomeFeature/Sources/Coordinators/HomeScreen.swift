//
//  HomeScene.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SearchFeature
import TCACoordinators

public struct HomeScreen: Reducer {
    public enum State: Equatable {
        case home(HomeStore.State)
        case search(SearchStore.State)
    }

    public enum Action {
        case home(HomeStore.Action)
        case search(SearchStore.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: /State.home, action: /Action.home) {
            HomeStore()
        }
        Scope(state: /State.search, action: /Action.search) {
            SearchStore()
        }
    }
}
