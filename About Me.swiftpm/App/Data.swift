/*
See the License.txt file for this sample’s licensing information.
*/

//import Foundation
import SwiftUI

struct Info {
    let image: String
    let name: String
    let title: String
    let url: URL?
    let story: String
    let hobbies: [String]
    let foods: [String]
    let colors: [Color]
    let funFacts: [String]
}

let information = Info(
    image: "Placeholder",
    name: "K1ngHandy",
    title: "GitHub",
    url: URL(string: "https://github.com/")!,
    story: "My coding journey began \n several years ago and has since \n evolved into working prototypes -🦁",
    hobbies: ["book.and.wrench.fill", "brain.head.profile", "ticket.fill"],
    foods: ["🥐", "🌮", "🍣"],
    colors: [Color.blue, Color.cyan, Color.indigo],
    funFacts: [
        "The femur is the longest and largest bone in the human body.",
        "The moon is 238,900 miles away.",
        "Prince’s last name was Nelson.",
        "503 new species were discovered in 2020.",
        "Ice is 9 percent less dense than liquid water.",
        "You can spell every number up to 1,000 without using the letter A.\n\n...one, two, three, four...ninety-nine...nine hundred ninety-nine 🧐",
        "A collection of hippos is called a bloat.",
        "White sand beaches are made of parrotfish poop.",
    ]
)
