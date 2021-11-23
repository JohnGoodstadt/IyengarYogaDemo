//
//  Created by John Goodstadt
//
//
//

import SwiftUI

struct AnimalDetailView: View {
	// MARK: - PROPERTIES
	
	let animal: Animal
	
	// MARK: - BODY
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .center, spacing: 20) {
				// HERO IMAGE
				Image(animal.image)
					.resizable()
					.scaledToFit()
				
				// TITLE
				Text(animal.name.uppercased())
					.font(.largeTitle)
					.fontWeight(.heavy)
					.padding(.vertical, 8)
					.foregroundColor(.primary)
					.background(
						Color.accentColor
							.frame(height: 6)
							.offset(y: 24)
					)
					.lineLimit(1)
					.minimumScaleFactor(0.5)
					.truncationMode(.tail)
					.padding(.horizontal)
				
				// HEADLINE
				Text(animal.headline)
					.font(.headline)
					.multilineTextAlignment(.leading)
					.foregroundColor(.accentColor)
					.padding(.horizontal)
				
				// was MAP - now PLAY mp3
				Group {
					HeadingView(headingImage: "speaker.2", headingText: "Pronunciation")
						.padding(.top,8)
					
					InsetPlayMP3View(animal: animal)
						.padding(.top,-8)
				}
				.padding(.horizontal)
				
				// GALLERY
				Group {
					//HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "More Pictures")
					
					InsetGalleryView(animal: animal)
				}
				.padding(.horizontal)
				
				
				
				// FACTS
				Group {
					HeadingView(headingImage: "questionmark.circle", headingText: "Did you know?")
					
					InsetFactView(animal: animal)
				}
				.padding(.horizontal)
				
				// DESCRIPTION
				Group {
					HeadingView(headingImage: "info.circle", headingText: "All about \(animal.name)")
					
					Text(animal.description)
						.multilineTextAlignment(.leading)
						.layoutPriority(1)
				}
				.padding(.horizontal)
				
				// INSTRUCTIONS
				Group {
					HeadingView(headingImage: "flowchart", headingText: "Instructions")
					
					Text(animal.instructions)
						.multilineTextAlignment(.leading)
						.layoutPriority(1)
				}
				.padding(.horizontal)
				
				// LINK
				Group {
					HeadingView(headingImage: "books.vertical", headingText: "Learn More")
					
					ExternalWeblinkView(animal: animal)
				}
				.padding(.horizontal)
			} //: VSTACK
			.navigationBarTitle("Learn about \(animal.name)", displayMode: .inline)
		} //: SCROLL
	}
}

// MARK: - PREVIEW

struct AnimalDetailView_Previews: PreviewProvider {
	static let animals: [Animal] = Bundle.main.decode("animals.json")
	
	static var previews: some View {
		NavigationView {
			AnimalDetailView(animal: animals[0])
		}
		.previewDevice("iPhone 12 Pro")
	}
}
