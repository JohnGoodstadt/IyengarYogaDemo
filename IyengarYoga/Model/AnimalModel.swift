//
//  Created by John Goodstadt
//
//
//

import SwiftUI

struct Animal: Codable, Identifiable, Comparable {
	static func < (lhs: Animal, rhs: Animal) -> Bool {
		lhs.name < rhs.name
	}
	
	let id: String
	let name: String
	let headline: String
	let description: String
	let instructions: String
	let contra: String
	let link: String
	let image: String
	let gallery: [String]
	let fact: [String]
	let mp3name:String
}
