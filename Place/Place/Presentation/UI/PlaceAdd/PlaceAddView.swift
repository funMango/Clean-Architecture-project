//
//  PlaceAddView.swift
//  Place
//
//  Created by 이민호 on 8/16/24.
//

import SwiftUI

struct PlaceAddView: View {
    @StateObject var viewModel: PlaceAddVM
    @State var content = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    TextField("이름", text: $viewModel.name)
                    TextField("주소", text: $viewModel.address)
                }
                
                Section{
                    TextField("내용", text: $viewModel.content, axis: .vertical)
                        .lineLimit(10...20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("장소 추가")
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        
                    } label: {
                        Text("추가")
                            .foregroundStyle(viewModel.name.isEmpty ? .gray : .red)
                    }
                    .disabled(viewModel.name.isEmpty)
                }
            }
        }
    }
}



#Preview {
    PlaceAddView(viewModel: PlaceAddVM())
}
