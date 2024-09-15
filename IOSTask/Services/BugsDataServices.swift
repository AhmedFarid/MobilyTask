//
//  BugsDataServies.swift
//  IOSTask
//
//  Created by Farido on 15/09/2024.
//

import Foundation
import CoreData

class BugsDataServies {
    private let container: NSPersistentContainer
    private let containerName: String = "BugsContainer"
    private let entityName: String = "BugsEntity"

    @Published var savedEntities: [BugsEntity] = []

    init() {
        self.container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            guard let self = self else {return}
            if let error = error {
                print("Error Loading coreDate! \(error)")
            }
            self.getBugs()
        }
    }

    func updatePortfolio(bug: BugsModel) {
        if let entity = savedEntities.first(where: {$0.id == bug.id}) {
            if entity.id != nil {
                update(entity: entity, bug: bug)
            } else {
                delete(entity: entity)
            }
        } else {
            add(bug: bug)
        }
    }

    private func getBugs() {
        let request = NSFetchRequest<BugsEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Data! \(error)")
        }
    }

    private func add(bug: BugsModel) {
        let entity = BugsEntity(context: container.viewContext)
        entity.id = bug.id
        entity.bugTitle = bug.bugTitle
        entity.bugDesc = bug.bugDesc
        entity.bugImage = bug.bugImage
        applyChanges()
    }

    private func update(entity: BugsEntity, bug: BugsModel) {
        entity.bugTitle = bug.bugTitle
        entity.bugDesc = bug.bugDesc
        entity.bugImage = bug.bugImage
        applyChanges()
    }

    private func delete(entity: BugsEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving Data! \(error)")
        }
    }

    private func applyChanges() {
        save()
        getBugs()
    }

}
