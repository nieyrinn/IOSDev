import SwiftUI

struct ContentView: View {
    
    let itemNames: [String] = [
        "Five Nights at Freddy's",
        "Silent Hill 2 Remake",
        "Parasocial",
        "Fran Bow",
        "Rusty Lake: Roots",
        "Sally Face",
        "Omori",
        "Resident Evil 7",
        "Little Nightmares",
        "Corpse Party"
    ]
    
    let itemIcons: [String] = [
        "moon.stars.fill",
        "smoke.fill",
        "person.crop.circle.badge.exclamationmark",
        "pills.fill",
        "leaf.fill",
        "theatermask.and.paintbrush.fill",
        "lightbulb.slash.fill",
        "house.lodge.fill",
        "eye.fill",
        "cross.fill"
    ]
    
    let itemDescriptions: [String] = [
        "You're a night guard at Freddy Fazbear's Pizza where animatronics come alive after dark and hunt you through flickering cameras.",
        "James Sunderland returns to the fog-covered town after receiving a letter from his dead wife, confronting manifestations of guilt and trauma.",
        "A Chilla's Art game about a late-night radio host who discovers an obsessed listener has been getting dangerously close.",
        "A young girl wakes in a mental asylum after her parents' murder. Mysterious red pills reveal a grotesque hidden reality.",
        "A dark puzzle adventure spanning generations of the Vanderboom family, revealing their cursed bloodline through disturbing rituals.",
        "A boy with a prosthetic face moves into a haunted apartment complex and investigates a gruesome murder mystery with his friend Larry.",
        "A surreal psychological RPG about a hikikomori boy who retreats into a dreamworld while a devastating secret slowly resurfaces.",
        "Ethan Winters searches for his missing wife in a Louisiana plantation, trapped by the terrifyingly deranged Baker family.",
        "A tiny girl named Six navigates the Maw — a vast underwater vessel filled with grotesque inhabitants who want to devour her.",
        "Students are transported to a cursed elementary school after a ritual goes wrong, trapped with vengeful ghosts."
    ]
    
    let itemRatings: [Int] = [
        3, // FNAF
        4, // Silent Hill 2
        2, // Parasocial
        3, // Fran Bow
        4, // Rusty Lake Roots
        2, // Sally Face
        3, // Omori
        5, // RE7
        3, // Little Nightmares
        4  // Corpse Party
    ]
    
    @State var currentIndex: Int = 0
    @State var tapCount: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Image(systemName: itemIcons[currentIndex])
                .font(.system(size: 80))
                .foregroundStyle(.purple)
            
            Text(itemNames[currentIndex])
                .font(.title)
                .bold()
            
            Divider()
                .padding(.horizontal)
            
            Text(itemDescriptions[currentIndex])
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Difficulty:")
                .font(.headline)
            
            if itemRatings[currentIndex] == 0 {
                Text("Not rated yet")
                    .font(.title3)
            } else {
                Text(String(repeating: "💀", count: itemRatings[currentIndex]))
                    .font(.title3)
            }
            
            Spacer()
            
            Button("Surprise Me!") {
                var newIndex: Int
                repeat {
                    newIndex = Int.random(in: 0..<itemNames.count)
                } while newIndex == currentIndex
                currentIndex = newIndex
                tapCount += 1
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            
            Text("Cards explored: \(tapCount)")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
