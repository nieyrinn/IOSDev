//
//  FavoriteModels.swift
//  tableview
//
//  Created by nieyrinn on 14.11.2025.
//

import Foundation

enum Section: Int, CaseIterable {
    case movies = 0
    case music
    case books
    case courses

    var title: String {
        switch self {
        case .movies:  "Favorite Movies"
        case .music:   "Favorite Music"
        case .books:   "Favorite Books"
        case .courses: "Favorite University Courses"
        }
    }
}

struct FavoriteItem {
    let title: String
    let subtitle: String
    let review: String
    let imageName: String?
    let sfSymbol: String?
}

struct FavoritesData {
    static let movies: [FavoriteItem] = [
        .init(
            title: "Interstellar",
            subtitle: "Christopher Nolan · 2014",
            review: "A team of explorers travels through a wormhole in space in an attempt to ensure humanity's survival.",
            imageName: "interstellar",
            sfSymbol: nil
        ),
        .init(
            title: "Blade Runner 2049",
            subtitle: "Denis Villeneuve · 2017",
            review: "A young blade runner uncovers a longhidden secret that could plunge whats left of society chaos.",
            imageName: "blade_runner_2049",
            sfSymbol: nil
        ),
        .init(
            title: "Arrival",
            subtitle: "Denis Villeneuve · 2016",
            review: "A linguist works with the communication with alien after mysterious spacecraft appear around the world.",
            imageName: "arrival",
            sfSymbol: nil
        ),
        .init(
            title: "Inception",
            subtitle: "Christopher Nolan · 2010",
            review: "A thief who steals corporate secrets is given the inverse task of planting an idea into a CEO's mind.",
            imageName: "inception",
            sfSymbol: nil
        ),
        .init(
            title: "The Matrix",
            subtitle: "The Wachowskis · 1999",
            review: "A hacker discovers the true nature of reality and his role in the war against its controllers.",
            imageName: "the_matrix",
            sfSymbol: nil
        )
    ]



    static let music: [FavoriteItem] = [
            .init(
                title: "To Pimp a Butterfly",
                subtitle: "Kendrick Lamar · 2015",
                review: "A complex, jazz-infused hip-hop masterpiece exploring identity, politics, and culture.",
                imageName: "pimp",
                sfSymbol: nil
            ),
            .init(
                title: "Rumours",
                subtitle: "Fleetwood Mac · 1977",
                review: "One of the best-selling albums ever, filled with emotional tension and timeless melodies.",
                imageName: "rumours",
                sfSymbol: nil
            ),
            .init(
                title: "After Hours",
                subtitle: "The Weeknd · 2020",
                review: "A dark synthwave-inspired pop record featuring Blinding Lights and a cinematic atmosphere.",
                imageName: "after_hours",
                sfSymbol: nil
            ),
            .init(
                title: "Random Access Memories",
                subtitle: "Daft Punk · 2013",
                review: "Warm analog sound, disco revival, and the global hit Get Lucky.",
                imageName: "ram",
                sfSymbol: nil
            ),
            .init(
                title: "OK Computer",
                subtitle: "Radiohead · 1997",
                review: "A groundbreaking alternative rock album exploring technology, alienation, and modern society.",
                imageName: "ok_computer",
                sfSymbol: nil
            )
        ]

    static let books: [FavoriteItem] = [
        .init(
            title: "Clean Code",
            subtitle: "Robert C. Martin · 2008",
            review: "Teaches how to write readable and clean software without turning your project into chaos.",
            imageName: "clean_code",
            sfSymbol: nil
        ),
        .init(
            title: "The Pragmatic Programmer",
            subtitle: "David Thomas · 1999",
            review: "A book on thinking like a mature developer, workflow, and building systems.",
            imageName: "pragmatic_programmer",
            sfSymbol: nil
        ),
        .init(
            title: "Design Patterns: OOP",
            subtitle: "Gamma, Helm · 1994",
            review: "Classic book introducing core design patterns such as Singleton, Factory, Observer, and Strategy.",
            imageName: "design_patterns",
            sfSymbol: nil
        ),
        .init(
            title: "Refactoring",
            subtitle: "Martin Fowler · 1999",
            review: "Explains proven techniques for improving code structure while keeping behavior unchanged.",
            imageName: "refactoring",
            sfSymbol: nil
        ),
        .init(
            title: "The Clean Coder",
            subtitle: "Robert C. Martin · 2011",
            review: "Focuses on professional discipline, responsibility, and mindset required to be a true software craftsman.",
            imageName: "clean_coder",
            sfSymbol: nil
        )
    ]


    static let courses: [FavoriteItem] = [
        .init(
            title: "iOS Development",
            subtitle: "by Arman Myrzakanuarov",
            review: "Covers Swift, UIKit, layouts, app architecture, and building production-ready iOS applications.",
            imageName: "ios_dev",
            sfSymbol: nil
        ),
        .init(
            title: "Object-Oriented Programming",
            subtitle: "by Pakita Shamoi",
            review: "Explores encapsulation, polymorphism, and OOP design principles.",
            imageName: "oop",
            sfSymbol: nil
        ),
        .init(
            title: "Software Engineering",
            subtitle: "by Aldamuratov Zhomart",
            review: "Focuses on development, design principles, teamwork, testing strategies, and large-scale project thinking.",
            imageName: "software_engineering",
            sfSymbol: nil
        ),
        .init(
            title: "Introduction to Business Management",
            subtitle: "by Askar Aituov",
            review: "Provides understanding fundamentals of modern management.",
            imageName: "ibm",
            sfSymbol: nil
        ),
        .init(
            title: "Computer Architecture",
            subtitle: "by Sukhrab Yoldash",
            review: "Explains CPUs, memory hierarchy, cycles, and how hardware design impacts software performance.",
            imageName: "comp_arch",
            sfSymbol: nil
        )
    ]


    static func items(for section: Section) -> [FavoriteItem] {
        switch section {
        case .movies:  movies
        case .music:   music
        case .books:   books
        case .courses: courses
        }
    }
}
