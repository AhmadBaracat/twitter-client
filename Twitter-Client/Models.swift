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
  
    
    static func decode(j: JSON) -> Decoded<User> {
        return curry(User.init)
            <^> j <| "name"
            <*> j <| "screen_name"
            <*> j <| "description"
            <*> j <| "profile_image_url"
    }
}
