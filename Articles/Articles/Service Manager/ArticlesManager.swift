//
//  ArticlesManager.swift
//  Articles
//
//  Created by AbdulNaveed Soudagar on 08/11/18.
//  Copyright © 2018 AbdulNaveed Soudagar. All rights reserved.
//

import Foundation

// ArticleAPI With all details
struct ArticleAPI {
    
    // API Key
    static func apiKey() -> String {
        return "99106728dc594f2aa85198d4f4e51bab"
    }
    
    // Base End Point
    static func baseEndPoint() -> String {
        return "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/"
    }
    
    // Invoking API
    static func getMostPopularArticlesAPI(section:String,period:Int) -> String {
        return "\(self.baseEndPoint())\(section)/\(period).json?api-key=\(self.apiKey())"
    }
}

// An Article Object
struct Article : Decodable {
    var adxKeywords:String
    var url:String
    var column:String?
    var section:String?
    var byline:String?
    var type:String?
    var title:String?
    var abstract:String?
    var date:String?
    var source:String?
    var id:Int?
    var assetId:Int?
    var views:Int?
    var descFacet:[String]?
    
    
    enum CodingKeys: String, CodingKey {
        case adxKeywords = "adx_keywords"
        case column
        case section
        case url
        case byline
        case type
        case abstract
        case date = "published_date"
        case source
        case id
        case assetId = "asset_id"
        case views
        case descFacet = "des_facet"
        case title
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adxKeywords = try values.decode(String.self, forKey: .adxKeywords)
        column = try values.decodeIfPresent(String.self, forKey: .column)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        url = try values.decode(String.self, forKey: .url)
        byline = try values.decodeIfPresent(String.self, forKey: .byline)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        assetId = try values.decodeIfPresent(Int.self, forKey: .assetId)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        descFacet = try values.decodeIfPresent([String].self, forKey: .descFacet)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

// An Article Response
struct ArticleResponse : Decodable
{
    var status: String
    var copyright: String
    var numResults: Int
    var results: [Article]
    
    enum CodingKeys: String, CodingKey
    {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(String.self, forKey: .status)
        copyright = try values.decode(String.self, forKey: .copyright)
        numResults = try values.decode(Int.self, forKey: .numResults)
        results = try values.decode([Article].self, forKey: .results)
    }
}


typealias articlesCompletion = ( _ results:[Article]?,_ error:Error?) -> Void

class ArticlesManager {
    static func getMostPopularArticles(days:Int,completionHandler: @escaping articlesCompletion) {
        let url = URL(string:ArticleAPI.getMostPopularArticlesAPI(section: "all-sections", period: days))
        let urlRequest = URLRequest(url:url!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ArticleResponse.self, from: responseData)
                completionHandler(response.results, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
