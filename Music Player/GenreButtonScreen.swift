//
//  GenreButtonScreen.swift
//  Music Player
//
//  Created by Edlyn Liew  on 12/8/20.
//  Copyright © 2020 Edlyn Liew . All rights reserved.
//

import UIKit
import MediaPlayer

class GenreButtonScreen: UIViewController {

    //create music player variable
    //once close app, the music player will stop
    var musicPlayer=MPMusicPlayerController.applicationMusicPlayer
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        
         //check for permission before play song
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                //force wrap it
                self.playGenre(genre: sender.currentTitle!)
            }
        }
    }

    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
 
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
