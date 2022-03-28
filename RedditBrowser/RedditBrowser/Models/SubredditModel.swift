//
//  SubredditModel.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import Foundation

class SubredditResult: Codable {
    let kind:String
    let data: SubredditData
}

class SubredditData: Codable {
    let dist:Int64
    let children: [SubredditModelResult]
}

class SubredditModelResult: Codable {
    let kind:String
    let data: SubredditModel
}

class SubredditModel: Codable {
    
    let id:String
    let name:String
    let display_name:String?
    let display_name_prefixed:String?
    let description:String?
    let header_img:String?
    let icon_img:String?
    let banner_img:String?
    let subscribers:Int?
    let url:String
    
    let author_fullname:String?
    let thumbnail:String?
    let ups:Int?
    let downs:Int?
    let permalink:String?
    let title:String?
}
