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
}
