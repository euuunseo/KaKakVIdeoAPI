//
//  KakaoAPIManager.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = ["Authorization" : "KakaoAK b74617ab95c9f3ca7b9399f233bec009"]
    
    func callRequest(type: Endpoint, query: String, completionHandler : @escaping (KakaoVideoAPI) -> Void ) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + text
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: KakaoVideoAPI.self) { respones in
            
            guard let result = respones.value else { return }
            
            completionHandler(result)
            
        }
    }
}
