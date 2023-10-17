//
//  EndPoint.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/27.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    case video
    
    var requestURL: String {
        switch self {
        case .blog : return URL.makeEndPointString("blog?query=")
        case .cafe : return URL.makeEndPointString("cafe?query=")
        case .video: return URL.makeEndPointString("vclip?query=")
        }
    }
}
