//
//  User.swift
//  Learning-SwiftUI
//
//  Created by Sarathi Kannan S on 02/01/24.
//

import Foundation

public struct User : Codable, Identifiable {
    public var id: Int
    var name: String
    var userName: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case userName = "username"
        case email, phone, website
        case company
        case address
    }
}

struct Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipCode: String
    var geoLocation: GeoLocation
    
    enum CodingKeys: String, CodingKey {
        case street, suite, city
        case zipCode = "zipcode"
        case geoLocation = "geo"
    }
}

struct GeoLocation: Codable {
    var latitude: String
    var longitude: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
    
    enum CodingKeys: String, CodingKey {
        case name, catchPhrase, bs
    }
}
