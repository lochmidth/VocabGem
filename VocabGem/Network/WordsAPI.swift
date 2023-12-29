//
//  WordsAPI.swift
//  VocabGem
//
//  Created by Alphan Ogün on 30.12.2023.
//

import Foundation
import Moya

enum WordsAPI {
    case searchWords(letterPatter: String)
    case getWordDetails(word: String)
}

extension WordsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://wordsapiv1.p.rapidapi.com")!
    }
    
    var path: String {
        switch self {
        case .searchWords:
            return "/words/"
        case .getWordDetails(let word):
            return "/words/\(word)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case let .searchWords(letterPattern):
            return .requestParameters(parameters: ["letterPattern": letterPattern,
                                                   "limit": 20,
                                                   "page": 1], encoding: URLEncoding.default)
        case .getWordDetails:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com",
            "X-RapidAPI-Key": "0a88629ce4msh03be90628e82e14p1b0eb1jsnc40fc356a6a3"
        ]
    }
    
    
}
