//
//  LibraryMP3.swift
//  Iyenga Yoga
//
//  Created by John goodstadt on 16/11/2021.
//

import Foundation
import AVFoundation

protocol LibraryMP3Delegate {
	
	func audioPlayerDidFinishPlaying() //so callers know mp3 has finished
	
}

public class LibraryMP3:NSObject,AVAudioPlayerDelegate {
	
	var audioPlayer: AVAudioPlayer?
	var audioPlayerDelegate: LibraryMP3Delegate?
	
	func isPlaying() -> Bool {
		
		if let player = self.audioPlayer {
			if player.isPlaying {
				return true
			}
		}
		return false
	}
	func stop() {
		if let player = self.audioPlayer {
			if player.isPlaying {
				player.stop()
			}
		}
	}
	func currentTime() ->  Float {
		return Float(audioPlayer?.currentTime ?? 0.0)
	}
	func  playMp3(_ name:String,caller_delegate:LibraryMP3Delegate){
		
		guard !name.isEmpty else{
			return
		}
		
		if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
			do {
				self.audioPlayerDelegate = caller_delegate
				try audioPlayer = AVAudioPlayer(contentsOf: url)
				audioPlayer?.delegate = self
				audioPlayer?.play()
			} catch {
				print("Couldn't play audio. Error: \(error)")
			}
		}
		
		
	}
	static func mp3exists(_ name:String) ->  Bool {
		
		var returnValue = false
		
		guard !name.isEmpty else{
			return returnValue
		}
		
		if let _ = Bundle.main.url(forResource: name, withExtension: "mp3") {
			returnValue =  true
		}
		
		return returnValue
	}
	static func mp3duration(_ name:String) ->  Double {
		
		var returnValue = 1.0
		
		guard !name.isEmpty else{
			return returnValue
		}
		
		if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
			do {
				let player = try AVAudioPlayer(contentsOf: url)
				player.prepareToPlay()
				returnValue =  player.duration
			} catch {
				return returnValue
			}
		}
		
		return returnValue
	}
	//MARK: delegate functions
	public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){

		print("LibraryMP3.audioPlayerDidFinishPlaying()")

		audioPlayerDelegate?.audioPlayerDidFinishPlaying()
	}
}
