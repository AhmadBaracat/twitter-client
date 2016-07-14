//
//  Models.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/9/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import Foundation
import Argo
import Curry


struct Response: Decodable {
    let users: [User]
    let next_cursor_str: String
    
    static func decode(j: JSON) -> Decoded<Response> {
        return curry(Response.init)
            <^> j <|| "users"
            <*> j <| "next_cursor_str"
    }
}

struct User: Decodable {
    var name: String
    var screen_name: String
    var description: String
    var profile_image_url: String
    var profile_banner_url: String?
    var profile_background_color: String?
  
    static func decode(j: JSON) -> Decoded<User> {
        let s = curry(User.init)
            <^> j <| "name"
            <*> j <| "screen_name"
            <*> j <| "description"
            <*> j <| "profile_image_url"
         return s
            <*> j <|? "profile_banner_url"
            <*> j <|? "profile_background_color"
        
    }
}

struct Tweet: Decodable {
    let text: String
    let entities: Entity?
    
    static func decode(j: JSON) -> Decoded<Tweet> {
        return curry(Tweet.init)
            <^> j <| "text"
            <*> j <|? "entities"
    }
}

struct Entity: Decodable {
    let media: [MediaEntity]?
    
    static func decode(j: JSON) -> Decoded<Entity> {
        return curry(Entity.init)
            <^> j <||? "media"
    }
}

struct MediaEntity: Decodable {
    let media_url: String?
    
    static func decode(j: JSON) -> Decoded<MediaEntity> {
        return curry(MediaEntity.init)
            <^> j <|? "media_url"
    }
}