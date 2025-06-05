//
//  PostsViewModel.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//

import Foundation


class PostsViewModel {
    var posts: [Post] = []

    func fetchPosts(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion()
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    self.posts = try JSONDecoder().decode([Post].self, from: data)
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Network error:", error)
            }

            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }
}
