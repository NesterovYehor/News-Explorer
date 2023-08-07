//
//  CoreView.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 04.08.2023.
//

import SwiftUI

struct CoreView: View {
    @StateObject var vm =  NewslineViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(height: 50)
                    .shadow(radius: 10)
                    .overlay {
                        TextField("Type here your request", text: $vm.searchQuery)
                            .padding()
                    }
                    .padding()
                Button {
                    vm.getURl()
                } label: {
                    NavigationLink(destination: NewslineView()) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.blue)
                            .frame(height: 50)
                            .shadow(radius: 10)
                            .padding()
                            .overlay {
                                Text("Search")
                                    .foregroundColor(.white)
                            }
                    }
                }
            }
        }
    }
}

struct CoreView_Previews: PreviewProvider {
    static var previews: some View {
        CoreView()
    }
}
