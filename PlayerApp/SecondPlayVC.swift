//
//  SecondPlayVC.swift
//  PlayerApp
//
//  Created by seema on 7/18/17.
//  Copyright © 2017 IndiaNIC. All rights reserved.
//

import UIKit

class SecondPlayVC: UIViewController {
    
    
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBAction func btnPlayPause(_ sender: UIButton) {
        
        if (sender.isSelected){
            //song is playing , pause the song
            lblStatus.text = "Music stopped"
            sender.isSelected = false
            UtilityClass.playerClass.pause()
            
        }else{
            //song is paused , play the song
            lblStatus.text = "Music Playing"
            sender.isSelected = true
            UtilityClass.playerClass.play()
        }
    }
    
    func nextSong(){
        let url : URL = URL.init(string: "http://desimusicmix.com:8000/HQ?type=.mp3/;stream.mp3")!
        UtilityClass.playerClass.setUpPlayer(url,self)
        UtilityClass.playerClass.controller = self
        self.btnPlayPause(btnPlayPause)
    }
    
    func previousSong(){
        let url : URL = URL.init(string: "http://desimusicmix.com:8000/HQ?type=.mp3/;stream.mp3")!
        UtilityClass.playerClass.setUpPlayer(url,self)
        UtilityClass.playerClass.controller = self
        self.btnPlayPause(btnPlayPause)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  <source src="http://desimusicmix.com:8000/HQ?type=.mp3/;stream.mp3" type="audio/mpeg" autoplay="true">
        let url : URL = URL.init(string: "http://desimusicmix.com:8000/HQ?type=.mp3/;stream.mp3")!
        UtilityClass.playerClass.setUpPlayer(url,self)
        UtilityClass.playerClass.controller = self
        self.btnPlayPause(btnPlayPause)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
