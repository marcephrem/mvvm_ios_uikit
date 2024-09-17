//
//  PeopleView.swift
//  iosStory
//
//  Created by marcephrem on 17/09/2024.
//

import Foundation

struct UserResponse: Codable {
    let data : [PersonResponse]
}

struct PersonResponse : Codable {
    let email: String
    let firstName:String
    let lastName:String
}

