//
//  ContentView.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 04.08.2023.
//

import SwiftUI

struct NewslineView: View {
    @StateObject var vm = NewslineViewModel()
    var body: some View{
        NavigationView {
            if vm.allArticles.isEmpty{
                menu
                    .navigationTitle("Type query to search")
                    .padding(.bottom, UIScreen.main.bounds.height * 0.7)
            }
            else{
                if vm.searchQueryIsEmpty{
                    menu
                        .navigationTitle("Type query to search")
                        .padding(.bottom, UIScreen.main.bounds.height * 0.7)
                }
                else{
                    articleList
                        .navigationTitle(vm.searchQuery)
                }
            }
        }
        .searchable(text: $vm.searchQuery)
        .onSubmit(of: .search) {
            vm.searchQueryIsEmpty = false
            Task{
                await vm.searchArticle()
            }
        }
        .onChange(of: vm.searchQuery) { newValue in
            if vm.searchQuery.isEmpty{
                vm.searchQueryIsEmpty.toggle()
            }
        }
    }
}

struct NewslineView_Previews: PreviewProvider {
    static var previews: some View {
        NewslineView()
    }
}

extension NewslineView{
    private var articleList: some View{
        List{
            ForEach(vm.allArticles) { article in
                NavigationLink {
                    ArticleView(article: article)
                } label: {
                    VStack{
                        Text(article.title)
                            .font(.body)
                            .padding(.bottom)
                        .fontWeight(.bold)
                        Text(article.description ?? "")
                            .font(.footnote)
                    }
                    
                }
            }
        }
    }
    private var menu: some View{
        Menu {
            Button("publishedAt"){
                vm.searchBy = .publishedAt
                print(vm.searchBy)
            }
            Button("popularity"){
                vm.searchBy = .popularity
                print(vm.searchBy)

            }
            Button("relevancy"){
                vm.searchBy = .relevancy
                print(vm.searchBy)

            }
        } label: {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .frame(width: 350, height: 50)
                .overlay {
                    Text("\(vm.searchBy.rawValue)")
                        .foregroundColor(.white)
                        .font(.title3)
                }
        }
    }
}
