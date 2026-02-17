//
//  UIProgressViewRepresentable.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import SwiftUI

struct UIProgressViewRepresentable: UIViewRepresentable {
    
    @ObservedObject var progressTracker: ProgressTracker
    
    func makeUIView(context: Context) -> UIProgressView {
        let progressView = UIProgressView()
        progressView.progress = progressTracker.progress
        progressView.backgroundColor = UIColor(named: "ProgressViewColor")
        progressView.tintColor = .white
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        return progressView
    }
    
    func updateUIView(_ progressView: UIProgressView, context: Context) {
        progressView.setProgress(progressTracker.progress, animated: true)
    }
}
