

import Foundation

// MARK: - PostGetPostList
struct PostGetPostList: Codable {
    let status, msg: String
    let postList: [PostPostList]
    let totalAds: Int
    let advertisementData: [PostAdvertisementDatum]
    let adOffset: Int
    let baseURL: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case postList = "post_list"
        case totalAds = "total_ads"
        case advertisementData = "advertisement_data"
        case adOffset = "ad_offset"
        case baseURL = "base_url"
    }
}

// MARK: - PostAdvertisementDatum
struct PostAdvertisementDatum: Codable {
    let pkID, advertiserName, mobileNo, city: String
    let adType, adName, adWebsiteURL, adImagePath: String
    let displayType: String
    let newWebsiteURL: String
    let videoThumbnail, isImpressClick: String

    enum CodingKeys: String, CodingKey {
        case pkID = "pk_id"
        case advertiserName = "advertiser_name"
        case mobileNo = "mobile_no"
        case city
        case adType = "ad_type"
        case adName = "ad_name"
        case adWebsiteURL = "ad_website_url"
        case adImagePath = "ad_image_path"
        case displayType = "display_type"
        case newWebsiteURL = "new_website_url"
        case videoThumbnail = "video_thumbnail"
        case isImpressClick = "is_impress_click"
    }
}

// MARK: - PostPostList
struct PostPostList: Codable {
    let pkID, postName, postImg1Path, userID: String
    let productCategoryID, price, usedNewType, location: String
    let locationOld, additionalKeywords, postStatus, postBy: String
    let postByLocation: String
    let profilePicPath, businessName: String?
    let distance, favourite: String

    enum CodingKeys: String, CodingKey {
        case pkID = "pk_id"
        case postName = "post_name"
        case postImg1Path = "post_img1_path"
        case userID = "user_id"
        case productCategoryID = "product_category_id"
        case price
        case usedNewType = "used_new_type"
        case location, locationOld
        case additionalKeywords = "additional_keywords"
        case postStatus = "post_status"
        case postBy = "post_by"
        case postByLocation = "post_by_location"
        case profilePicPath = "profile_pic_path"
        case businessName = "business_name"
        case distance, favourite
    }
}
