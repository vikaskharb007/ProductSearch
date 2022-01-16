//
//  NetworkError.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation

enum NetworkRequestError: Error {
    case jsonParseError
    case apiError(String)
    case networkNotReachable
    case genericError(String)
    
    var title: String {
        switch self {
        case .jsonParseError:
           return "Data error"
            
        case .apiError(let description), .genericError(let description):
            return "Request Failed - Error \(description)"
            
        case .networkNotReachable:
            return "No Internet"
            
        }
    }
    
    var message: String {
        switch self {
        
        case .jsonParseError, .apiError(_), .genericError(_) :
            return "Something went wrong please try again later"
            
        case .networkNotReachable:
           return "You are not connected to internet, please check your internet connection and try again"
        }
    }
}
