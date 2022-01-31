//
//  APIClient.swift
//  SpaceNews
//
//  Created by ramil on 31.01.2022.
//

import Foundation

struct SpaceData: Codable, Identifiable {
    var id: Int
    var title: String
    var url: String
    var imageUrl: String
    var newsSite: String
    var summary: String
    var publishedAt: String
}

@MainActor class SpaceAPI: ObservableObject {
    
    @Published var news: [SpaceData] = []
    
    func getData() {
        
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles?_limit=10") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                let tempError = error!.localizedDescription
                DispatchQueue.main.async {
                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", imageUrl: "Error", newsSite: "Error", summary: "Error! Try to refresh!", publishedAt: "Error")]
                }
                return
            }
            
            let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            
            DispatchQueue.main.async {
                self.news = spaceData
            }
        }.resume()
    }
}
