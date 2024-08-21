//
//  PlaceListView.swift
//  Place
//
//  Created by 이민호 on 8/14/24.
//

import SwiftUI

struct PlaceListView: View {
    @StateObject var viewModel: PlaceListVM
    @State var isSheetPresented = false
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.places, id: \.self) { place in
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
            .onAppear {
                    Task {
                        await viewModel.listen()
                    }
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
    PlaceListView(
        viewModel: PlaceListVM(
            interactor: PlaceInteractor(
                dbRepository: PlaceDBRepository()
            )
        )
    )
}
