//
//  PlayerClass.swift
//  PlayerApp
//
//  Created by seema on 7/18/17.
//  Copyright © 2017 IndiaNIC. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

enum REPEAT_MODE{
    case RepeatNone
    case RepeatOne
    case RepeatAll
}

enum SHUFFLE{
    case YES
    case NO
}
class PlayerClass: NSObject {
    
    var avPlayer : AVPlayer = AVPlayer()
    var controller : Any = ()
    var onPlayBackControlChange: ((_ status : String) -> Void)?
    var repeatMode : REPEAT_MODE = .RepeatNone
    var shuffle : SHUFFLE = .NO
    
    override init() {
        super.init()
    }
    
    func setUpPlayer(_ url : URL , _ controller : Any){
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        //initialize method
        let playerItem : AVPlayerItem = AVPlayerItem.init(url: url)
        
        if (avPlayer.currentItem == nil)
        {
            avPlayer = AVPlayer.init(playerItem: playerItem)
        }else{
            self.removeObserver(avPlayer.currentItem!)
            self.pause()
            avPlayer.replaceCurrentItem(with: playerItem)
        }
        
        self.addObserver(playerItem) // add playerItem observer
        self.controller = controller // to know current view
        self.saveInformationToShowOnMediaControl() // show control on lock screen
    }
   
    func pause(){
        self.changePlayBackButtonIcon(false)
        avPlayer.pause()
      //  onPlayBackControlChange!("Pause")
    }
    func play(){
        self.changePlayBackButtonIcon(true)
        avPlayer.play()
     //   onPlayBackControlChange!("play")
    }
    
    func changePlayBackButtonIcon(_ status : Bool){
        if (self.controller is ViewController){
            (self.controller as! ViewController).btnPlayPause.isSelected = status
        }else{
            (self.controller as! SecondPlayVC).btnPlayPause.isSelected =  status
        }
    }
    func removeObserver(_ playerItem : AVPlayerItem){
        do{
            playerItem.removeObserver(self, forKeyPath: "status")
            playerItem.removeObserver(self, forKeyPath: "playbackBufferEmpty")
            playerItem.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        }
        catch{
        
        }
    }
    func addObserver(_ playerItem : AVPlayerItem){
        playerItem.addObserver(self, forKeyPath: "status", options:NSKeyValueObservingOptions(), context: nil)
        playerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options:NSKeyValueObservingOptions(), context: nil)
        playerItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options:NSKeyValueObservingOptions(), context: nil)
     //   avPlayer.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions(), context: nil)
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            print("Change at keyPath = \(String(describing: keyPath)) for \(String(describing: object))")
        }
        
        if keyPath == "playbackBufferEmpty" {
            (self.controller as! ViewController).activityIndicator.startAnimating()
            print("playbackBufferEmpty - Change at keyPath = \(String(describing: keyPath)) for \(String(describing: object))")
        }
        
        if keyPath == "playbackLikelyToKeepUp" {
            (self.controller as! ViewController).activityIndicator.stopAnimating()
            print("Change at keyPath = \(String(describing: keyPath)) for \(String(describing: object))")
        }
    }
    
    func saveInformationToShowOnMediaControl(){
        let mediaCenter = MPNowPlayingInfoCenter.default()
        mediaCenter.nowPlayingInfo = [MPMediaItemPropertyTitle : "Title"]
    }
    
    func remoteControlReceived(with event: UIEvent?)
    {
        if (self.controller is SecondPlayVC){
            
        }
        print(event?.subtype)
    }
    
}
