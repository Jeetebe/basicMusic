//
//  ViewController.swift
//  IOS8SwiftPlayMusicTutorial
//
//  Created by Arthur Knopper on 31/05/15.
//  Copyright (c) 2015 Arthur Knopper. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var trackTitle: UILabel!
    @IBOutlet var playedTime: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    var timer:NSTimer!
 let soundUrl = "http://45.121.26.141/w/colorring/al/601/785/0/0000/0001/399.mp3"
    @IBAction func playOrPauseMusic(sender: AnyObject) {
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
        } else {
            
//             audioPlayer.prepareToPlay()
//             audioPlayer.play()
            playSound2(soundUrl)
            
            isPlaying = true
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        }
    }
    func downloadFileFromURL(url:NSURL){
        var downloadTask:NSURLSessionDownloadTask
        downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(url, completionHandler: { (URL, response, error) -> Void in
            
            self.play(URL!)
            
        })
        
        downloadTask.resume()
        
    }
    func play(url:NSURL) {
        print("playing \(url)")
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    func playSound2(soundUrl: String)
    {
        do {
            let fileURL = NSURL(string:soundUrl)
            let soundData = NSData(contentsOfURL:fileURL!)
            self.audioPlayer = try AVAudioPlayer(data: soundData!)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            //audioPlayer.delegate = self
            audioPlayer.play()
        } catch {
            print("Error getting the audio file")
        }
    }

    @IBAction func stopMusic(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        isPlaying = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let urlstring = "http://radio.spainmedia.es/wp-content/uploads/2015/12/tailtoddle_lo4.mp3"
//        let url = NSURL(string: urlstring)
//        print("the url = \(url!)")
//        downloadFileFromURL(url!)
//        isPlaying = true

        
        trackTitle.text = "Future Islands - Tin Man"
        let soundUrl = "http://45.121.26.141/w/colorring/al/601/785/0/0000/0001/399.mp3"
        let sound = NSURL(fileURLWithPath: soundUrl)
        var path = NSBundle.mainBundle().URLForResource("Future Islands - Tin Man", withExtension: "mp3")
        //var error:NSError?
        
        //audioPlayer = AVAudioPlayer(contentsOfURL: path!, error: &error)
        do
        {
            //audioPlayer =  try AVAudioPlayer(contentsOfURL: path!)
            audioPlayer =  try AVAudioPlayer(contentsOfURL: sound)
        }
        catch
        {
            print(error)
        }

    }
    
    func updateTime() {
        var currentTime = Int(audioPlayer.currentTime)
        var minutes = currentTime/60
        var seconds = currentTime - minutes * 60
        
        playedTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

