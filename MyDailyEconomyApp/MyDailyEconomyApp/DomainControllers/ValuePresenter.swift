//
//  ValuePresenter.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol ValuePresenter {
    func present(value: Value) -> String
    //Añadir funcionalidad a medida que haga falta
}

extension ValuePresenter {
    func present(value: Value) -> String {
        return"\(value.amount) \(value.currency)"
    }
}

