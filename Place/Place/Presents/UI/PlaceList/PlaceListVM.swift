//
//  PlaceListVM.swift
//  Place
//
//  Created by 이민호 on 8/21/24.
//

import Foundation

class PlaceListVM: ObservableObject{
    @Published var places = [Place]()
    @Published var loadingState: Loadable = .notRequest
    let interactor: PlaceProtocol
    
    
    init(places: [Place] = [Place](), interactor: PlaceProtocol) {
        self.places = places
        self.interactor = interactor
    }
    
    @MainActor
    func listen() async {
        loadingState = .isLoading
        
        do {
            for try await places in try await interactor.listen() {
                self.places = places
            }
            loadingState = .loaded
        } catch {
            loadingState = .failed
            print("[Error] fetchPlaces: \(error)")
        }
    }
}
