//
//  AudioManager.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/7/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public class TFAudioManager : NSObject , AVAudioPlayerDelegate {
    
    static let sharedInstance = TFAudioManager()
    
    var audioPlayer : AVAudioPlayer?
    var isPlaying = false;
    var playingStoryID : String?
    
    public func playAudioFromStory( story : TFStory)
    {
        
        
        if self.audioPlayer != nil
        {
            if self.isPlaying == true
            {
                self.audioPlayer?.stop()
                self.isPlaying = false
                
                if let playId = self.playingStoryID
                {
                    if playId == story.story_id
                    {
                        
                        return
                    }
                }
                
            }
        }
        
        if let rec_url = story.recURL
        {
            
            let audioData = NSData(contentsOfURL: NSURL(string: rec_url)!)
            
            self.audioPlayer = try? AVAudioPlayer(data: audioData!)
            self.audioPlayer?.delegate = self
            audioPlayer?.volume = 0.6
            audioPlayer?.prepareToPlay()
            audioPlayer?.numberOfLoops = 0
            playingStoryID = story.story_id
            
            audioPlayer?.play()
            
            self.isPlaying = true
        }
    }
    
    public func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
    }
}