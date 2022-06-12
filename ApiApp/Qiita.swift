//
//  Qiita.swift
//  ApiApp
//
//  Created by 北川 海渡 on 2021/04/27.
//

import Foundation

struct APIClient {

    static func fetchArticle(_ completion: @escaping ([Article]) -> Void) {
        let components = URLComponents(string: "https://qiita.com/api/v2/items")
        guard let url = components?.url else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decorder = JSONDecoder()
                do {
                    let articles = try decorder.decode([Article].self, from: data)
                    print(articles)
                    completion(articles)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error ?? "Error")
            }
        }
        task.resume()
    }
}
