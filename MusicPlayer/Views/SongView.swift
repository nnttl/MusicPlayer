//
//  SongView.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import SwiftUI

struct SongView: View {
    
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var musicPlayerViewModel: MusicPlayerViewModel
    @ObservedObject var progressTracker: ProgressTracker
    
    //MARK: - Body
    var body: some View {
        ZStack {
            CustomBackground()
            VStack {
                headerView
                if let song = musicPlayerViewModel.currentSong {
                    makeSongInfoView(with: song)
                }
                if let progressTracker = musicPlayerViewModel.progressTracker {
                    UIProgressViewRepresentable(progressTracker: progressTracker)
                }
                timeStampsView
                if let song = musicPlayerViewModel.currentSong {
                    makeButtonsView(with: song)
                }
                Spacer()
            }
            .padding()
            .padding(.horizontal, 16)
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.down").foregroundStyle(.white)
                    .scaleEffect(1.2)
            }
            
            Spacer()
            
            Text(musicPlayerViewModel.playlistInfo.playlistName)
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .foregroundStyle(.white)
                .scaleEffect(1.2)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 40)
    }
    
    @ViewBuilder
    private func makeSongInfoView(with song: Song) -> some View {
        Image(song.imageName)
            .resizable()
            .frame(width: 360, height: 360)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding(.bottom, 40)
        
        
        Text(song.name).foregroundStyle(.white)
            .font(.system(size: 24, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 0.5)
        
        Text(song.artist).foregroundStyle(.customGray)
            .font(.system(size: 20, weight: .medium))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
    }
    
    private var timeStampsView: some View {
        HStack {
            Text(progressTracker.formatTimePassed())
                .foregroundStyle(.customGray)
                .font(.system(size: 16))
            
            Spacer()
            
            Text(progressTracker.formatTimeRemaining())
                .foregroundStyle(.customGray)
                .font(.system(size: 16))
        }.padding(.bottom, 40)
    }
    
    @ViewBuilder
    private func makeButtonsView(with song: Song) -> some View {
        HStack {
            Button(action: { musicPlayerViewModel.previous(song) }) {
                Image(systemName: "backward.end.fill")
                    .foregroundStyle(.white)
                    .scaleEffect(2)
            }
            Spacer()
            
            Button(action: { musicPlayerViewModel.togglePause() }) {
                ZStack {
                    Circle().fill(.white)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: musicPlayerViewModel.isPlaying ? "pause.fill" :  "arrowtriangle.right.fill")
                        .foregroundStyle(.black)
                        .scaleEffect(1.5)
                }
            }
            Spacer()
            
            Button(action: { musicPlayerViewModel.next(song) }) {
                Image(systemName: "forward.end.fill")
                    .foregroundStyle(.white)
                    .scaleEffect(2)
            }
        }.padding(.bottom, 20)
            .padding(.horizontal, 80)
    }
}
