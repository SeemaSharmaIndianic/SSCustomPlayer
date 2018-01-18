//
//  ViewController.swift
//  PlayerApp
//
//  Created by seema on 7/18/17.
//  Copyright © 2017 IndiaNIC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func btnSecondScreen_onClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "openSecondScreen", sender: nil)
    }
    @IBAction func btnPlayPause_onClick(_ sender: UIButton) {
        
        if (sender.isSelected){
            //song is playing , pause the song
            lblStatus.text = "Music stopped"
            sender.isSelected = false
            UtilityClass.playerClass.pause()
            
        }else{
            
            let url : URL = URL.init(string: "http://cld2098fls.audiovideoweb.com/live/_definst_/6c3flslive2212/playlist.m3u8")!
            let playerItem : AVPlayerItem = AVPlayerItem.init(url: url)
            
            if(UtilityClass.playerClass.avPlayer.currentItem != playerItem){
                UtilityClass.playerClass.setUpPlayer(url,self)
            }
            //song is paused , play the song
            lblStatus.text = "Music Playing"
            sender.isSelected = true
            UtilityClass.playerClass.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url : URL = URL.init(string: "http://cld2098fls.audiovideoweb.com/live/_definst_/6c3flslive2212/playlist.m3u8")!
        
        // URL.init(string: "http://www.abc.net.au/res/streaming/audio/mp3/news_radio.pls")!
        //http://www.abc.net.au/res/streaming/audio/mp3/grandstand.pls
        UtilityClass.playerClass.setUpPlayer(url,self)
        UtilityClass.playerClass.controller = self
        self.btnPlayPause_onClick(btnPlayPause)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

