//
//  StructCategory.swift
//  MplusSoft Machine test
//
//  Created by Somnath on 25/09/21.
//

import Foundation

// MARK: - ProductCategory
struct ProductCategory: Codable {
    let status, msg: String
    let productCategoryList: [ProductCategoryList]
    let baseURL: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case productCategoryList = "product_category_list"
        case baseURL = "base_url"
    }
}

// MARK: - ProductCategoryList
struct ProductCategoryList: Codable {
    let pkID, categoryNameEnglish: String
    let usedNewApplicable: UsedNewApplicable
    let categoryIconThumbPath, activeCategoryIconThumbPath, categoryName, languageCode: String

    enum CodingKeys: String, CodingKey {
        case pkID = "pk_id"
        case categoryNameEnglish = "category_name_english"
        case usedNewApplicable = "used_new_applicable"
        case categoryIconThumbPath = "category_icon_thumb_path"
        case activeCategoryIconThumbPath = "active_category_icon_thumb_path"
        case categoryName = "category_name"
        case languageCode = "language_code"
    }
}

enum UsedNewApplicable: String, Codable {
    case no = "no"
    case yes = "yes"
}

