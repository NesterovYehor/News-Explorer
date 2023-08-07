//
//  ArticleView.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 06.08.2023.
//

import SwiftUI

struct ArticleView: View {
    @StateObject var vm = NewslineViewModel()
    var article: Article
    var body: some View {
        VStack{
            if let imageUrlString = article.urlToImage{
                if let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl, content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 370)
                    }, placeholder: {
                        ProgressView()
                    })
                    Text(article.title)
                        .font(.title2)
                        .frame(alignment: .center)
                        .fontWeight(.bold)
                    Text(article.description ?? article.content)
                        .font(.callout)
                        .padding()
                    Spacer()
                    HStack{
                        Text(article.author ?? "")
                            .padding()
                        Spacer()
                        Text(article.source.name)
                            .padding()
                    }
                    Text(article.publishedAt)
                }
            }
            else{
                Text("No Image")
                    .font(.title)
                Spacer()
                Text(article.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                Text(article.description ?? article.content)
                    .font(.callout)
                    .padding()
                Spacer()
                Text(article.url)
                    .foregroundColor(.blue)
                HStack{
                    Text(article.author ?? "")
                        .padding()
                    Spacer()
                    Text(article.source.name)
                        .padding()
                }
                Text(article.publishedAt)
            }
            
        }
//        .onAppear(){
//            Task{
//                await vm.downloadImage(url: article.urlToImage)
//
//            }
//        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article(source: Article.Source(id: "the-verge", name: "The Verge"), author: "Justine Calma", title: "Can banks push Bitcoin to clean up its act?", description: "Banks and asset managers have a big stake in Bitcoin, so Greenpeace wants them to crack down on the cryptocurrency’s pollution.", url:  "https://www.theverge.com/2023/7/11/23778688/bitcoin-energy-emissions-climate-change-banks-asset-managers-greenpeace", urlToImage:  "https://cdn.vox-cdn.com/thumbor/ODx_QBV2qCE_dfhHtwtaZ8W6J8I=/0x0:7144x4743/1200x628/filters:focal(3572x2372:3573x2373)/cdn.vox-cdn.com/uploads/chorus_asset/file/24763884/1235926940.jpg", publishedAt: "2023-07-11T14:00:00Z", content: "Can banks push Bitcoin to clean up its act?\r\nCan banks push Bitcoin to clean up its act?\r\n / Banks and asset managers have a big stake in Bitcoin, so Greenpeace wants them to crack down on the crypto… [+4372 chars]"))
    }
}
