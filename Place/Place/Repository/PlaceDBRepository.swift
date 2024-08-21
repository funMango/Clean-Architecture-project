//
//  PlaceDBRepository.swift
//  Place
//
//  Created by 이민호 on 8/20/24.
//

import Foundation
import FirebaseFirestore

protocol PlaceDBProtocol{
    func save(_ place: Place) async throws
    func listen() async throws -> AsyncThrowingStream<[Place], Error>
}

struct PlaceDBRepository: PlaceDBProtocol{
    private let db = Firestore.firestore()
    
    func save(_ place: Place) async throws {
        let ref = db.collection("Place").document(place.id)
        
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try ref.setData(from: place) { error in
                    if error == nil {
                        continuation.resume(returning: ())
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func listen() async throws -> AsyncThrowingStream<[Place], Error>  {
        AsyncThrowingStream<[Place], Error> { continuation in
            let ref = db.collection("Place")
                        
            ref.addSnapshotListener { (snapshot, error) in
                if let error = error {
                    continuation.finish(throwing: error)
                    return
                }
                
                do {
                    let places = try snapshot?.documents.compactMap{ document -> Place? in
                        try document.data(as: Place.self)
                    } ?? []
                    continuation.yield(places)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
