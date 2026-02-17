
//
//  ProgressTracker.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import Combine
import AVFAudio

final class ProgressTracker: ObservableObject {
    
    //MARK: - Properties
    
    @Published private(set) var progress: Float = 0.0
    
    private var audioPlayer: AVAudioPlayer?
    private(set) var timePassed: TimeInterval = 0
    private(set) var duration: TimeInterval?
    private(set) var timer: Timer?
    
    
    //MARK: - Init
    init(audioPlayer: AVAudioPlayer?) {
        self.audioPlayer = audioPlayer
        self.duration = audioPlayer?.duration
    }
    
    
    //MARK: - Methods
    func startTimer() {
        stopTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
            guard let audioPlayer = self.audioPlayer, let duration = self.duration else { return }
            self.timePassed = audioPlayer.currentTime
            self.progress = Float(audioPlayer.currentTime / duration)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    //format timestamps
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    func formatTimePassed() -> String {
        formatTime(timePassed)
    }
    
    func formatTimeRemaining() -> String {
        guard let duration = duration else { return ""}
        return "-\(formatTime(duration - timePassed))"
    }
}
