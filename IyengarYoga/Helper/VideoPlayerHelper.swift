//
//  Created by John Goodstadt
//
//
//

import Foundation
import AVKit

var videoPlayer: AVPlayer?

func playVideo(fileName: String, fileFormat: String) -> AVPlayer {
	
//	let tempVideoName = "Gomukhasana-arms-only_video"
	let tempVideoName = "tadasana"
	
	
  if Bundle.main.url(forResource: tempVideoName, withExtension: fileFormat) != nil {
    videoPlayer = AVPlayer(url: Bundle.main.url(forResource: tempVideoName, withExtension: fileFormat)!)
    videoPlayer?.play()
  }
  return videoPlayer!
}
