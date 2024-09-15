//
//  HomeViewModel.swift
//  IOSTask
//
//  Created by Farido on 15/09/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allBugs: [BugsModel] = []
    @Published var bug: BugsModel? = nil

    private let bugsDataServices = BugsDataServices()
    private var cancellable = Set<AnyCancellable>()

    init() {
        addPortfolioCoins()
    }

    func addPortfolioCoins() {
        bugsDataServices.$savedEntities
            .map(mapAllBugsEntityToBugsMode)
            .sink(receiveValue: { bugsEntity in
                self.allBugs = bugsEntity
                print(self.allBugs)
            })
            .store(in: &cancellable)
    }

    private func mapAllBugsEntityToBugsMode(bugsEntity: [BugsEntity]) -> [BugsModel] {
        bugsEntity
            .map { bug in
                let newBug = BugsModel(id: bug.id ?? "", bugTitle: bug.bugTitle ?? "", bugDesc: bug.bugDesc ?? "", bugImage: bug.bugImage ?? Data())
                return newBug
            }
    }

    func updateBug(bug: BugsModel, isDelete: Bool) {
        bugsDataServices.updateBug(bug: bug, isDelete: isDelete)
    }

    
}
