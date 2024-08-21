//
//  PlaceAddInteractor.swift
//  Place
//
//  Created by 이민호 on 8/20/24.
//

import Foundation

protocol PlaceProtocol{
    func save(_ place: Place) throws
    func listen() async throws -> AsyncThrowingStream<[Place], Error>
}

struct PlaceInteractor: PlaceProtocol {
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
    
    func listen() async throws -> AsyncThrowingStream<[Place], Error> {
        do {
            return try await dbRepository.listen()            
        } catch {
            throw error
        }
    }
}

    
