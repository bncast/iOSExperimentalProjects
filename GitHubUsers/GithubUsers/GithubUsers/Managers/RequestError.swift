//
//  RequestError.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import Foundation

enum RequestError:Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
