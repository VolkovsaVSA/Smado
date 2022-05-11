//
//  CategoryViewModel.swift
//  Smado
//
//  Created by Sergei Volkov on 16.02.2022.
//

import Foundation

class CategoryViewModel: ObservableObject {
    static let shared = CategoryViewModel()
    @Published var categoryGridID = UUID()
    @Published var documentID = UUID()
}
