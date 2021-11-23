//
//  InsetPlayMP3View.swift
//  Iyenga Yoga
//
//  Created by John goodstadt on 16/11/2021.
//

import SwiftUI
import Combine

let PLAY_ICON = "play.fill"
let PAUSE_ICON = "pause.fill"

struct InsetPlayMP3View: View, LibraryMP3Delegate {
	
	
	
	// MARK: - PROPERTIES
	
	let animal: Animal
	private let libraryMP3 = LibraryMP3()
	

	
	@State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State private var mp3Exists: Bool = false
	@State private var isPlaying: Bool = false
	@State private var toolbarIcon: String = PLAY_ICON
	@State private var sliderValue: Double = 0
	@State private var sliderMax: Double = 2 //typical
	
	// MARK: - BODY
	
	var body: some View {
		VStack () {

			HStack(alignment: .center, spacing: 15) {
				
				Button(action: {
					
					if mp3Exists {
						isPlaying = !isPlaying
						toolbarIcon = isPlaying ? PAUSE_ICON : PLAY_ICON
						
						if !isPlaying {
							sliderValue = 0
							stopTimer()
						}
						else{
							
						
							sliderValue = 0
							self.startTimer()
							
							let duration = LibraryMP3.mp3duration(animal.mp3name)
							sliderMax = duration//LibraryMP3.mp3duration("dandasana")
							print("\(animal.mp3name) mp3duration is \(sliderMax)")
							libraryMP3.playMp3(animal.mp3name, caller_delegate: self)
						
							
						}
					}else{
						print("cannot play that which does not exist")
				    }
					

				}) {
					Image(systemName: toolbarIcon)
					.font(.title2)
					.foregroundColor(mp3Exists ? .blue : .gray)
					.frame(width: 50)
					.frame(height: 50)
					.clipShape(Circle())
					.overlay(Circle().stroke(mp3Exists ?  Color.blue : Color.gray, lineWidth: 2) )
					.disabled( !mp3Exists)


					
				}
				.onReceive(timer) { input in
					sliderValue = Double( libraryMP3.currentTime() )
				}
				
				Slider(value: $sliderValue, in: 0...sliderMax)
					.padding(.leading,16)
					.padding(.trailing,16)
					.frame(height: 60)
					.inExpandingRectangle()
				
			}//:HSTACK
		}//: VSTACK
		.onAppear(perform: {
			
			self.stopTimer()
			mp3Exists = LibraryMP3.mp3exists(animal.mp3name)
			
			
			let duration = LibraryMP3.mp3duration(animal.mp3name)
			sliderMax = duration//LibraryMP3.mp3duration("dandasana")
			print("onAppear:\(animal.mp3name) mp3duration is \(sliderMax)")
		})
		.onDisappear {
			print("ContentView disappeared!")
			if isPlaying {
				libraryMP3.stop()
				stopTimer()
			}
		}
		.padding(.top,16)
		
		
	} //:VIEW
	
	
	func stopTimer() {
		self.timer.upstream.connect().cancel()
	}
	func startTimer() {
		self.timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
	}
	func updateSlider(_ timer: Timer) {
		print("updateSlider")
	}
	func audioPlayerDidFinishPlaying() {
		self.stopTimer()
		sliderValue = 0
		toolbarIcon = PLAY_ICON
		isPlaying = false
	}
}

// MARK: - PREVIEW
struct InsetPlayMP3View_Previews: PreviewProvider {
	static let animals: [Animal] = Bundle.main.decode("animals.json")
	
	static var previews: some View {
		InsetPlayMP3View(animal: animals[0])
			.previewLayout(.sizeThatFits)
			.padding()
	}
}
