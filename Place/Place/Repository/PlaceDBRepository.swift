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
}
