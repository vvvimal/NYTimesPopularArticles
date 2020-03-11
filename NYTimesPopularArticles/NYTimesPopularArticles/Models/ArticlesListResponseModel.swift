//
//  ArticlesListResponseModel.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit

struct ArticlesListResponseModel: Codable {
    let status: String?
    let copyright:String?
    let num_results: Int?
    let results:[ArticleDataModel]?
}

struct ArticleDataModel:Codable {
    let uri:String?
    let url:String?
    let id:Int??
    let asset_id:Int?
    let source: String?
    let published_date:String?
    let updated:String?
    let section:String?
    let subsection:String?
    let nytdsection:String?
    let adx_keywords:String?
    let column:String?
    let byline:String?
    let type:String?
    let title:String?
    let abstract:String?
    let des_facet:[String]?
    let org_facet:[String]?
    let per_facet:[String]?
    let geo_facet:[String]?
    let media:[MediaDataModel]?
    let eta_id:Int?
}

struct MediaDataModel: Codable {
    let type:String?
    let subtype:String?
    let caption:String?
    let copyright:String?
    let approved_for_syndication:Int?
    let media_metadata:[MediaMetaDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approved_for_syndication
        case media_metadata = "media-metadata"
    }
}

struct MediaMetaDataModel:Codable {
    let url:String?
    let format:String?
    let height:Int?
    let width:Int?
}
