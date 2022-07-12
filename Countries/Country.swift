//
//  Country.swift
//  Countries
//
//  Created by Adam Paluszewski on 27/06/2022.
//

import Foundation

struct Country: Codable {
    var name: Name
    var region: String
    var landlocked: Bool
    var capital: [String]?
    var languages: Languages?
    var flags: Flags
    var population: Int
    var idd: Idd?   //nr kierunkowy
    var tld: [String]? //nazwa domeny
    var maps: Maps
    var car: Car
    var timezones: [String]
    var flag: String

}

struct Name: Codable {
    var common: String
    var official: String
}

struct Languages: Codable {
    var ell: String?
    var tur: String?
    var pol: String?
}

struct Flags: Codable {
    var png: String
    var svg: String
}

struct Idd: Codable {
    var root: String?
    var suffixes: [String]?
}

struct Maps: Codable {
    var googleMaps: String
}

struct Car: Codable {
    var side: String
}
