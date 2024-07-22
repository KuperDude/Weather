//
//  SoundManager.swift
//  Weather
//
//  Created by MyBook on 21.07.2024.
//

import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    private var player: AVAudioPlayer?
    
    private init() {}
    
    func playSound(named name: String, withExtension ext: String = "mp3") {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("Sound file not found: \(name).\(ext)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

