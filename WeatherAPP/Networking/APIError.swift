//
//  APIError.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import Foundation

// MARK: APIError
enum APIError: LocalizedError {
    case invalidURL
    case requestFailed
    case networkFailed
    case decodingFailed
    case dataFailed
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFailed:
            return "요청 실패입니다."
        case .networkFailed:
            return "통신에 실패했습니다."
        case .decodingFailed:
            return "디코딩에 실패했습니다."
        case .dataFailed:
            return "잘못된 데이터입니다."
        }
    }
}
