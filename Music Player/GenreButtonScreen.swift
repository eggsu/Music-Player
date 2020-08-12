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
    
    @IBOutlet var pausePlayButton: UIImageView!
    
    
    //create music player variable

    //once close app, the music player will stop

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //you can do any additional setup after loading the view here
        let nextButtonTapped = UITapGestureRecognizer(target:self,action:#selector(viewNextTapped(_:)))
        nextButtonTapped.numberOfTapsRequired=1
        nextButtonTapped.numberOfTouchesRequired=1
        
        let playPauseButtonTapped = UITapGestureRecognizer(target:self,action:#selector(viewPausePlayTapped(_:)))
               playPauseButtonTapped.numberOfTapsRequired=1
               playPauseButtonTapped.numberOfTouchesRequired=1
        
        nextButtonTap.addGestureRecognizer(nextButtonTapped)
        pausePlayButton.addGestureRecognizer(playPauseButtonTapped)
        
        pausePlayButton.isUserInteractionEnabled=true
        nextButtonTap.isUserInteractionEnabled=true
    }
    
    @objc func viewPausePlayTapped(_ gesture:UITapGestureRecognizer){
        musicPlayer.pause()
    }
    
    @objc func viewNextTapped(_ gesture: UITapGestureRecognizer){
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
