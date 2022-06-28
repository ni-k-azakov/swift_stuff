//
//  DiscountsViewModel.swift
//  Medilife
//
//  Created by Nikita Kazakov on 08.06.2022.
//

import Foundation
import Combine

class DiscountsViewModel: ObservableObject {
    @Published var response = DiscountsInfoResponse(response: [], discountID: -1, error: false, message: "Response not ready yet")
    
    init() {
        MedilifeApiClient.shared.getDiscounts()
            .assign(to: \.response, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
}
