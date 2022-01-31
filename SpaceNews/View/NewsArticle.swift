//
//  NewsArticle.swift
//  SpaceNews
//
//  Created by ramil on 31.01.2022.
//

import SwiftUI
import CachedAsyncImage

struct NewsArticle: View {
    let title: String
    let image: String
    let siteName: String
    let summary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(siteName)
                .foregroundColor(.blue)
                .italic()
            
            HStack(alignment: .center) {
                CachedAsyncImage(url: URL(string: image), transaction: Transaction(animation: .easeInOut)) { phrase in
                    if let image = phrase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .transition(.opacity)
                    } else {
                        HStack {
                            ProgressView()
                        }
                    }
                }
            }
            
            Text(title)
                .font(.headline)
                .padding(8)
            
            Text(summary)
                .lineLimit(6)
                .font(.body)
                .padding(8)
        }
    }
}

struct NewsArticle_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticle(title: "title", image: "image", siteName: "siteName", summary: "summary")
    }
}
