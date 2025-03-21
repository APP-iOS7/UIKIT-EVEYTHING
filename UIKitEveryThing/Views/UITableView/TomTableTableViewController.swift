//
//  TomTableTableViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class TomTableTableViewController: UITableViewController {
    
    fileprivate var data: [Product]?
    
    override func loadView() {
        super.loadView()
        Task {
            data = await fetchDataFromUrl()
            dump(data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// 비동기로 데이터 가져와버리기?
fileprivate extension TomTableTableViewController {
    func fetchDataFromUrl() async -> [Product] {
        let url = URL(string: "https://fakestoreapi.com/products")
        guard let url else { return [] }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                print("정상 응답 아님")
                return []
            }
            switch response.statusCode {
            case 200: print("ok")
            default:
                print("No")
            }
            let decoder = JSONDecoder()
            return try decoder.decode([Product].self, from: data)
        } catch {
            print(error)
        }
        return []
    }
}

// 데이터 모델링
fileprivate struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Codable {
        let rate: Double
        let count: Int
        
        enum CodingKeys: String, CodingKey {
            case rate
            case count
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case image
        case rating
    }
}
