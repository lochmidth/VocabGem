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
            let details = "definition,partOfSpeech,synonyms,examples"
            return .requestParameters(parameters: ["letterPattern": letterPattern,
                                                   "lettersMax": (letterPattern.count + 3),
                                                   "limit": 20,
                                                   "page": 1,
                                                   "hasDetails": details], encoding: URLEncoding.default)
        case .getWordDetails:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "X-RapidAPI-Host": wordsAPIHost,
            "X-RapidAPI-Key": wordsAPIKey
        ]
    }
    
    
}
