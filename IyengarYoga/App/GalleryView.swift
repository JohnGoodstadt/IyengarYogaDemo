//
//  Created by John Goodstadt
//
//
//

import SwiftUI

struct GalleryView: View {
	// MARK: - PROPERTIES
	
	@State var pushActive = false
	
	@State private var selectedAnimal: String = "dandasana"
	@State private var selectedName: String = "Dandasana"
	@State private var showAlert:Bool = false
	@State var animals: [Animal] = Bundle.main.decode("animals.json")
	
	@State private var mySelectedAnimal: Animal?// = animals[0]
	
	let haptics = UIImpactFeedbackGenerator(style: .medium)
	
	@State private var gridLayout: [GridItem] = [GridItem(.flexible())]
	@State private var gridColumn: Double = 3.0
	

	func gridSwitch() {
		gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
	}
	
	// MARK: - BODY
	
	var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .center, spacing: 30) {
					// MARK: - IMAGE
					
					Image(selectedAnimal)
						.resizable()
						.scaledToFit()
						.clipShape(Circle())
						.overlay(Circle().stroke(Color.white, lineWidth: 8))
					
					
					NavigationLink(destination: AnimalDetailView(animal: mySelectedAnimal ?? animals[0]),
								   isActive: self.$pushActive)
					{
						
						Button(action: {
							//self.showAlert.toggle()
							self.pushActive = true
							
						}, label: {
							Text("Details")
								.padding(.leading,32)
								.padding(.trailing,32)
								.padding(.top,8)
								.padding(.bottom,8)
								.font(.title2)
//								.foregroundColor(.white)
//								.background(Color.blue)
//								.cornerRadius(8)
						})
							.buttonStyle(PrimaryButtonStyle())
					}

					// MARK: - SLIDER
					
					Slider(value: $gridColumn, in: 2...4, step: 1)
						.padding(.horizontal)
						.onChange(of: gridColumn, perform: { value in
							gridSwitch()
						})
					
					
					
					// MARK: - GRID
					
					LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
						ForEach(animals) { item in
							Image(item.image)
								.resizable()
								.scaledToFit()
								.clipShape(Circle())
								.overlay(Circle().stroke(Color.white, lineWidth: 1))
								.onTapGesture {
									selectedAnimal = item.image
									selectedName = item.name
									haptics.impactOccurred()
									mySelectedAnimal = item
								}
						} //: LOOP
					} //: GRID
					.animation(.easeIn)
					.onAppear(perform: {
						//		  animals = animals.sorted(by: { $0.name < $1.name })
						//		  animals.sort(by: { $0.name < $1.name })
									animals.shuffle()
						gridSwitch()
					})
					.alert(isPresented: $showAlert) {
						Alert(
							title: Text("Not Yet implemented"),
							message: Text("Code still to be decided"),
							dismissButton: .default(Text("OK"))
						)
					}
				} //: VSTACK
				.padding(.horizontal, 10)
				.padding(.vertical, 50)
				//remove the default Navigation Bar space:
				.hiddenNavigationBarStyle()
			} //: SCROLL
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(MotionAnimationView())
		}//:NAVIGATION VIEW


		
	}
}

// MARK: - PREVIEW

struct GalleryView_Previews: PreviewProvider {
	static var previews: some View {
		GalleryView()
			.previewDevice("iPhone 12 Pro")
	}
}


struct NewView: View {
	
	var body: some View {
		Text("New View")
	}
}
