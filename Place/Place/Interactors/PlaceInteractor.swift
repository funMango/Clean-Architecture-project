//
//  PlaceAddInteractor.swift
//  Place
//
//  Created by 이민호 on 8/20/24.
//

import Foundation

protocol PlaceAddProtocol{
    func save(_ place: Place) throws
}

struct PlaceInteractor: PlaceAddProtocol {
    let dbRepository: PlaceDBProtocol
    
    func save(_ place: Place) throws {
        Task {
            do {
                try await dbRepository.save(place)
            } catch {
                throw error
            }
        }
    }
}

    