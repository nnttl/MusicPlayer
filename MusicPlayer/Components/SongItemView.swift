//
//  SongItemView.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import SwiftUI

struct SongItemView: View {
    
    //MARK: - Properties
    
    @ObservedObject var musicPlayerViewModel: MusicPlayerViewModel
    @State private var isPresented = false
    @State private var showPlayer = false
    
    var song: Song
    
    
    //MARK: - Body
    
    var body: some View {
        Button(action: {
            print("pressed \(song.name)")
            musicPlayerViewModel.play(song: song)
            isPresented.toggle()
        })
        {
            makeButtonContent(with: song)
        }
        .fullScreenCover(isPresented: $isPresented) {
            if let progressTracker = musicPlayerViewModel.progressTracker {
                SongView(musicPlayerViewModel: musicPlayerViewModel, progressTracker: progressTracker)
            }
        }
    }
    
    //MARK: - Methods
    
   private func makeButtonContent(with song: Song) -> some View {
        HStack {
            Image(song.imageName).resizable().frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            VStack(spacing: 4) {
                Text(song.name)
                    .foregroundStyle(song.id == musicPlayerViewModel.currentSong?.id ? .customGreen : .white)
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(song.artist).foregroundStyle(.customGray)
                    .font(.system(size: 14, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Image(systemName: "ellipsis")
                .foregroundStyle(.customGray)
        }
    }
}

#Preview {
    SongListView()
}
