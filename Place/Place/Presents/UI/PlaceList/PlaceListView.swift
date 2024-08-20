//
//  PlaceListView.swift
//  Place
//
//  Created by 이민호 on 8/14/24.
//

import SwiftUI

struct PlaceListView: View {
    @State private var mock = [
        Place(name: "양식", address: "강남구 논현동", content: ""),
        Place(name: "곱창", address: "서초구 서초동", content: ""),
        Place(name: "막창", address: "서초구 양재동", content: ""),
    ]
    @State var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mock, id: \.self) { place in
                    PlaceCellView(place: place)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("장소")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Text("추가")
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                PlaceAddView(
                    viewModel: PlaceAddVM(
                        interactor: PlaceInteractor(
                            dbRepository: PlaceDBRepository()
                        )
                    ),
                    isSheetPresented: $isSheetPresented
                )
            }
        }
    }
}

struct PlaceCellView: View {
    var place: Place
    
    var body: some View{
        VStack{
            HStack{
                Text(place.name)
                Spacer()
            }
            
            HStack{
                Text(place.address)
                    .foregroundStyle(.gray)
                    .font(.caption)
                Spacer()
            }
        }
    }
}

#Preview {
    PlaceListView()
}
