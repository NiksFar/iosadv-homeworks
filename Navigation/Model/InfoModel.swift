//
//  InfoModel.swift
//  Navigation
//
//  Created by Никита on 07.10.2023.
//

import Foundation

struct InfoObject: Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
}

struct NetworkService {
    
    static func loadData(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession.shared.dataTask(with: url) { data, responce, error in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
    
    static func request(stringURL: String) {
        let url = URL(string: stringURL)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, responce, error in
            print ("data", data as Any)
            //print ("responce", responce)
            if let httpResponse = responce as? HTTPURLResponse {
                print("statusCode \(httpResponse.statusCode)")
                print("allHeaderFields \(httpResponse.allHeaderFields)")
            }
            if let error = error {
                print ("error", error.localizedDescription)
            }
        }.resume()
    }
    
    static func jsonObject(with data: Data, options opt: JSONSerialization.ReadingOptions = []) -> String? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: opt)
//            if let title = json["title"] as? [String] {
//                print(title)
//            }
            guard let dict = json as? [[String: Any]] else {return nil}
            guard let firstElement = dict.first else {return nil}
            if let firstTitle = firstElement["title"] as? String {
                return firstTitle
            } else { return nil}
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func parse<T:Decodable>(jsonData: Data, model: T.Type) -> T? {
           do {
               let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
               print("Data Decoded!")
               return decodedData
           } catch {
               print("decode error")
               return nil
           }
       }
    
    static func loadLocalJson<T:Decodable>(resource: String, model: T.Type) -> [T]? {
        var tempArray: [T]
        let path = Bundle.main.path(forResource: resource, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            tempArray = try JSONDecoder().decode([T].self, from: data)
            return tempArray
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

struct Planet: Codable {
    let name: String
    let orbitalPeriod: String
    let residents: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
        case residents
    }
}

struct Residents: Codable {
    let residentName: String
    
    enum CodingKeys: String, CodingKey {
        case residentName = "name"
    }
}
