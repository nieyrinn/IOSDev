import Foundation
import UIKit

//тут я храню все данные айтемов которых потом юзал

struct Item {
    let title: String
    let subtitle: String
    let review: String
    let image: String
}

enum Section {
    case movie, music, book, course
}

struct data {
    static let movie: [Item] = [
        .init(title: "Interstellar", subtitle: "Christopher Nolan · 2014", review: "A team of explorers travels through a wormhole in space in an attempt to ensure humanity's survival.", image: "interstellar"),
        .init(title: "Blade Runner 2049", subtitle: "Denis Villeneuve · 2017", review: "A young blade runner uncovers a longhidden secret that could plunge whats left of society chaos.", image: "blade_runner_2049"),
        .init(title: "Arrival", subtitle: "Denis Villeneuve · 2016", review: "A linguist works with the communication with alien after mysterious spacecraft appear around the world.", image: "arrival"),
        .init(title: "Inception", subtitle: "Christopher Nolan · 2010", review: "A thief who steals corporate secrets is given the inverse task of planting an idea into a CEO's mind.", image: "inception"),
        .init(title: "The Matrix", subtitle: "The Wachowskis · 1999", review: "A hacker discovers the true nature of reality and his role in the war against its controllers.", image: "the_matrix"),
        .init(title: "The Dark Knight", subtitle: "Christopher Nolan · 2008", review: "Batman faces the Joker in a battle for Gotham’s soul.", image: "dk"),
        .init(title: "Dune", subtitle: "Denis Villeneuve · 2021", review: "Paul Atreides journeys to Arrakis in a political and spiritual epic.", image: "dune"),
        .init(title: "Her", subtitle: "Spike Jonze · 2013", review: "A man forms a bond with an AI that evolves beyond expectations.", image: "her"),
        .init(title: "The Prestige", subtitle: "Christopher Nolan · 2006", review: "Two rival magicians push obsession to dangerous extremes.", image: "pr"),
        .init(title: "Whiplash", subtitle: "Damien Chazelle · 2014", review: "A drummer faces brutal mentorship in pursuit of greatness.", image: "wh")
    ]
    
    static let music: [Item] = [
        .init(title: "To Pimp a Butterfly", subtitle: "Kendrick Lamar · 2015", review: "A complex, jazz-infused hip-hop masterpiece exploring identity, politics, and culture.", image: "pimp"),
        .init(title: "Rumours", subtitle: "Fleetwood Mac · 1977", review: "One of the bestselling albums ever with timeless melodies.", image: "rumours"),
        .init(title: "After Hours", subtitle: "The Weeknd · 2020", review: "A dark synthwave-inspired pop record.", image: "after_hours"),
        .init(title: "Random Access Memories", subtitle: "Daft Punk · 2013", review: "Warm analog sound and disco revival.", image: "ram"),
        .init(title: "OK Computer", subtitle: "Radiohead · 1997", review: "A groundbreaking alternative rock album.", image: "ok_computer"),
        .init(title: "Abbey Road", subtitle: "The Beatles · 1969", review: "An iconic rock album with legendary songwriting.", image: "ab"),
        .init(title: "DAMN.", subtitle: "Kendrick Lamar · 2017", review: "A sharp and introspective modern rap album.", image: "damn"),
        .init(title: "1989", subtitle: "Taylor Swift · 2014", review: "A clean synth-pop sound with massive global hits.", image: "1989"),
        .init(title: "Good Kid, M.A.A.D City", subtitle: "Kendrick Lamar · 2012", review: "A cinematic coming-of-age album.", image: "gk"),
        .init(title: "The Wall", subtitle: "Pink Floyd · 1979", review: "A conceptual rock opera about isolation and trauma.", image: "wallpf")
    ]


    static let book: [Item] = [
        .init(title: "Clean Code", subtitle: "Robert C. Martin · 2008", review: "Teaches how to write clean and maintainable software.", image: "clean_code"),
        .init(title: "The Pragmatic Programmer", subtitle: "Thomas & Hunt · 1999", review: "A guide on thinking like a mature developer.", image: "pragmatic_programmer"),
        .init(title: "Design Patterns", subtitle: "Gamma, Helm · 1994", review: "Classic book introducing essential design patterns.", image: "design_patterns"),
        .init(title: "Refactoring", subtitle: "Martin Fowler · 1999", review: "Techniques for safely improving code structure.", image: "refactoring"),
        .init(title: "The Clean Coder", subtitle: "Robert C. Martin · 2011", review: "Discipline and mindset required for professional developers.", image: "clean_coder"),
        .init(title: "Legacy Code", subtitle: "Michael Feathers · 2004", review: "How to work effectively with difficult legacy systems.", image: "lc"),
        .init(title: "Code Complete", subtitle: "Steve McConnell · 2004", review: "Comprehensive guide to software craftsmanship.", image: "cc"),
        .init(title: "Domain-Driven Design", subtitle: "Eric Evans · 2003", review: "Deep dive into modeling complex domains.", image: "ddd"),
        .init(title: "Mythical Man-Month", subtitle: "Fred Brooks · 1975", review: "Essays on software engineering and project management.", image: "mmm"),
        .init(title: "TAOCP", subtitle: "Donald Knuth · 1968", review: "Foundational text on algorithms and computation.", image: "taocp")
    ]


    static let course: [Item] = [
        .init(title: "iOS Development", subtitle: "Arman Myrzakanuarov", review: "Covers Swift, UIKit, layouts, and app architecture.", image: "ios_dev"),
        .init(title: "Object-Oriented Programming", subtitle: "Pakita Shamoi", review: "Explores encapsulation, polymorphism, and core OOP principles.", image: "oop"),
        .init(title: "Software Engineering", subtitle: "Aldamuratov Zhomart", review: "Design, teamwork, testing, and large-scale system thinking.", image: "software_engineering"),
        .init(title: "Business Management", subtitle: "Askar Aituov", review: "Fundamentals of management and decision-making.", image: "ibm"),
        .init(title: "Computer Architecture", subtitle: "Sukhrab Yoldash", review: "CPU, memory hierarchy, cycles, and hardware design.", image: "comp_arch"),
        .init(title: "Database", subtitle: "Aibek Kuralbayev", review: "SQL, normalization, indexing, and transactions.", image: "db"),
        .init(title: "Statistics", subtitle: "Kulpeshov Beibit", review: "Mathemathic and logic based tasks for improve probability solving.", image: "stats"),
        .init(title: "Web Devolopment", subtitle: "Sakina Mosavi", review: "HTML, CSS improving and learning Angular & Django frameworks.", image: "web"),
        .init(title: "Calculus 2", subtitle: "Arman Kudaibergenov", review: "Advanced mathematic functions, problem solving and other stuff.", image: "calc"),
        .init(title: "Information Communication Technology", subtitle: "Tomiris Ismagambetova.", review: "Principles of SQL , Excel, Power Point, and other stuff.", image: "ict")
    ]


    static func items(for section: Section) -> [Item] {
        switch section {
        case .movie:  movie
        case .music:   music
        case .book:   book
        case .course: course
        }
    }
}
