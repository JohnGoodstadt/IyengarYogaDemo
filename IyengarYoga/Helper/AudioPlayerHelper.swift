//
//  AudioPlayerHelper.swift
//  Iyenga Yoga
//
//  Created by John goodstadt on 16/11/2021.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playAudio(fileName: String, fileFormat: String) -> AVAudioPlayer {
	
	let tempAudioName = "dandasana"
	
	if let url = Bundle.main.url(forResource: tempAudioName, withExtension: "mp3") {
		do {
			try audioPlayer = AVAudioPlayer(contentsOf: url)
			audioPlayer?.play()
		} catch {
			print("Couldn't play audio. Error: \(error)")
		}
	}
	
	return audioPlayer!
	
}
