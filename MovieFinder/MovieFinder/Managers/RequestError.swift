//
//  RequestError.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//
import Foundation

enum RequestError:Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
