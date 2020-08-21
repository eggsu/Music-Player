//
//  GenreButtonScreen.swift
//  Music Player
//
//  Created by Edlyn Liew  on 12/8/20.
//  Copyright © 2020 Edlyn Liew . All rights reserved.
//

import UIKit
import MediaPlayer
import SwiftUI

class GenreButtonScreen: UIViewController, UIGestureRecognizerDelegate{

    var musicPlayer=MPMusicPlayerController.applicationMusicPlayer
    
    @IBOutlet var nextButtonTap: UIImageView!

    @IBOutlet var pauseButtonTap: UIImageView!
    
    @IBOutlet var prevButtonTap: UIImageView!
    
    @IBOutlet var playingButtonTap: UIImageView!
    
    @IBOutlet var musicProgressBar: UIProgressView!
    
    //create music player variable

    //once close app, the music player will stop

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //you can do any additional setup after loading the view here
        let nextButtonTapped = UITapGestureRecognizer(target:self,action:#selector(viewNextSongTapped(_:)))
        nextButtonTapped.numberOfTapsRequired=1
        nextButtonTapped.numberOfTouchesRequired=1
        
        let pauseButtonTapped = UITapGestureRecognizer(target:self,action:#selector(viewPauseTapped(_:)))
               pauseButtonTapped.numberOfTapsRequired=1
               pauseButtonTapped.numberOfTouchesRequired=1
        
        let playButtonTapped = UITapGestureRecognizer(target:self,action:#selector(viewPlayTapped(_:)))
                     playButtonTapped.numberOfTapsRequired=1
                     playButtonTapped.numberOfTouchesRequired=1
              
        
        let prevButtonTapped = UITapGestureRecognizer(target:self,action:#selector(viewPrevSongTapped(_:)))
                 prevButtonTapped.numberOfTapsRequired=1
                 prevButtonTapped.numberOfTouchesRequired=1
          
        
        nextButtonTap.addGestureRecognizer(nextButtonTapped)
        
        playingButtonTap.addGestureRecognizer(playButtonTapped)
              
        pauseButtonTap.addGestureRecognizer(pauseButtonTapped)
                   
        prevButtonTap.addGestureRecognizer(prevButtonTapped)
        
        pauseButtonTap.isUserInteractionEnabled=true
        nextButtonTap.isUserInteractionEnabled=true
        prevButtonTap.isUserInteractionEnabled=true
        playingButtonTap.isUserInteractionEnabled=true
    }
    
 
//to pause the music
    @objc func viewPlayTapped(_ gesture:UITapGestureRecognizer){
        musicPlayer.play()
         pauseButtonTap.isHidden=false
         playingButtonTap.isHidden=true
         
     }
    
    //to let music play
    @objc func viewPauseTapped(_ gesture:UITapGestureRecognizer){
        musicPlayer.pause()
        pauseButtonTap.isHidden=true
        playingButtonTap.isHidden=false
        
    }
    
    @objc func viewPrevSongTapped(_ gesture:UITapGestureRecognizer){
        musicPlayer.skipToPreviousItem()
        
    }
    
    @objc func viewNextSongTapped(_ gesture: UITapGestureRecognizer){
        musicPlayer.skipToNextItem()
    }

    
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        
         //check for permission before play song
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                //force wrap it
                
                   DispatchQueue.main.async { // Correct
                self.playGenre(genre: sender.currentTitle!)
                }
            }
        }
    }

    

    func playGenre(genre: String){
        musicPlayer.stop()
        
        pauseButtonTap.isHidden=false
        playingButtonTap.isHidden=true
        
        //create the query
        let query=MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
     
        //applies the filter onto the song  you are going to get
        query.addFilterPredicate(predicate)
        
        //get back chosen genre
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()

    
    }
}
