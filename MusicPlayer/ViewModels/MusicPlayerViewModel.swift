//
//  MusicPlayerManager.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import Combine
import AVFoundation

final class MusicPlayerViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private(set) var songs: [Song] = [
        Song(name: "Jigsaw Falling Into Place", artist: "Radiohead", imageName: "InRainbows"),
        Song(name: "Under Pressure", artist: "Queen & David Bowie", imageName: "QueenBowie"),
        Song(name: "Just", artist: "Radiohead", imageName: "TheBends"),
        Song(name: "Overdue", artist: "Muse", imageName: "Showbiz"),
        Song(name: "Karma Police", artist: "Radiohead", imageName: "OKComputer"),
        Song(name: "Supermassive Black Hole", artist: "Muse", imageName: "BlackHolesCover"),
        Song(name: "Weird Fishes Arpeggi", artist: "Radiohead", imageName: "InRainbows"),
        Song(name: "Black Star", artist: "Radiohead", imageName: "TheBends"),
    ]
    
    private(set) var playlistInfo = PlaylistInfo(user: "John Doe", playlistName: "favs🎶")
    
    @Published  private(set) var isPlaying = false
    
    private(set) var audioPlayer: AVAudioPlayer?
    private(set) var progressTracker: ProgressTracker?
    private(set) var currentSong: Song?
    
    
    //MARK: - Methods
    
    func play(song: Song) {
        stop()
        currentSong = song
        audioPlayer = SongLoader.loadSong(with: song.name)
        audioPlayer?.prepareToPlay()
        
        progressTracker = ProgressTracker(audioPlayer: audioPlayer)
        
        audioPlayer?.play()
        isPlaying = true
        progressTracker?.startTimer()
    }
    
    func togglePause() {
        guard let player = audioPlayer else { return }
        if isPlaying {
            player.pause()
            progressTracker?.stopTimer()
        } else {
            player.play()
            progressTracker?.startTimer()
        }
        isPlaying.toggle()
    }
    
    func stop() {
        audioPlayer?.stop()
        progressTracker?.stopTimer()
        progressTracker = nil
        isPlaying = false
    }
    
    func next(_ currentSong: Song) {
        guard let currentSongIndex = songs.firstIndex(where: { $0.id == currentSong.id }) else { return }
        guard currentSongIndex < songs.count - 1 else { return }
        play(song: songs[currentSongIndex + 1])
    }
    
    func previous(_ currentSong: Song) {
        guard let currentSongIndex = songs.firstIndex(where: { $0.id == currentSong.id }) else { return }
        guard currentSongIndex > 0 else { return }
        play(song: songs[currentSongIndex - 1])
    }
}
