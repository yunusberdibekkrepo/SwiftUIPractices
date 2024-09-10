//
//  User.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 11.04.2024.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double

    var work: String {
        "Worker as Same Job"
    }

    var education: String {
        "Graduate Degree"
    }

    var aboutMe: String {
        "This is a sentence about me that will look good on my profile."
    }

    var basics: [UserInterest] {
        [
            .init(iconName: "ruler", emoji: nil, text: height.description),
            .init(iconName: "graduationcap", emoji: nil, text: education),
            .init(iconName: "wineglass", emoji: nil, text: "Socially"),
            .init(iconName: "moon.stars.fill", emoji: nil, text: "Virgo"),
        ]
    }

    var interests: [UserInterest] {
        [
            .init(iconName: nil, emoji: "🏃", text: "Running"),
            .init(iconName: nil, emoji: "🏋️‍♀️", text: "Gym"),
            .init(iconName: nil, emoji: "🎧", text: "Music"),
            .init(iconName: nil, emoji: "🍔", text: "Cooking"),
        ]
    }

    var images: [String] {
        [
            Constants.randomImage,
            "https://picsum.photos/500/500",
            "https://picsum.photos/700/700",
        ]
    }

    static var mock: User = .init(
        id: 23,
        firstName: "Yunus Emre",
        lastName: "Berdibek",
        age: 21,
        email: "com.yunusberdibekk@gmail.com",
        phone: "0545 XXX XXXX",
        username: "yunusberdibek",
        password: "xxxxxxxx",
        image: Constants.randomImage,
        height: 177,
        weight: 90
    )
}
