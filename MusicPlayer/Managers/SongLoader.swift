//
//  SongLoader.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import AVFAudio

final class SongLoader: ObservableObject {
    static func loadSong(with name: String) -> AVAudioPlayer? {
        if let sound = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                return try AVAudioPlayer(contentsOf: sound)
            } catch {
                print("AVAudioPlayer could not be instantiated.")
                return nil
            }
        } else {
            print("Audio file could not be found.")
            return nil
        }
    }
}
