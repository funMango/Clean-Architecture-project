//
//  PlaceAddVM.swift
//  Place
//
//  Created by 이민호 on 8/16/24.
//

import SwiftUI

class PlaceAddVM: ObservableObject {
    @Published var name = ""
    @Published var address = ""
    @Published var content = ""
    @Published var loadingState: Loadable = .notRequest
    
    let interactor: PlaceAddProtocol
    
    init(interactor: PlaceAddProtocol) {
        self.interactor = interactor
    }
    
    @MainActor
    func addPlace() {
        loadingState = .isLoading
        let place = Place(name: name, address: address, content: content)
        
        do {
            try interactor.save(place)
            loadingState = .loaded
        } catch {
            loadingState = .failed
            print("[Error] addPlace: \(error)")
        }
    }
}
