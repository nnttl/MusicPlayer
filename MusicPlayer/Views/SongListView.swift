//
//  SongListView.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import SwiftUI

struct SongListView: View {
    
    //MARK: - Properties
    
    @StateObject private var musicPlayerViewModel = MusicPlayerViewModel()
    
    //MARK: - Body
    var body: some View {
        ZStack {
            CustomBackground()
            VStack {
                playlistImage
                playlistHeaderView
                songsList
                
            }
        }
    }
    
    private var playlistImage: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(.inRainbows).resizable().frame(width: 100, height: 100)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 4,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                Image(.okComputer).resizable().frame(width: 100, height: 100)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 4
                        )
                    )
            }
            HStack(spacing: 0) {
                Image(.showbiz).resizable().frame(width: 100, height: 100)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 4,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                Image(.theBends).resizable().frame(width: 100, height: 100)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 4,
                            topTrailingRadius: 0
                        )
                    )
            }
        }.padding(.top, 24)
    }
    
    private var playlistHeaderView: some View {
        HStack {
            VStack(spacing: 8) {
                Text(musicPlayerViewModel.playlistInfo.playlistName)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 6) {
                    ZStack {
                        Circle()
                            .frame(width: 23)
                            .foregroundStyle(.customPurple)
                        
                        Text(String(musicPlayerViewModel.playlistInfo.user.first ?? "U"))
                            .font(.system(size: 12, weight: .regular))
                    }
                    
                    Text(musicPlayerViewModel.playlistInfo.user)
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .semibold))
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button(action: {
                musicPlayerViewModel.togglePause()
            }) {
                ZStack {
                    Circle().fill(.customGreen)
                        .frame(width: 53, height: 53)
                    
                    Image(systemName: musicPlayerViewModel.isPlaying ? "pause.fill" :  "arrowtriangle.right.fill")
                        .foregroundStyle(.black)
                        .scaleEffect(1.2)
                }
            }
        }.padding()
    }
    
    private var songsList: some View {
        List {
            ForEach(musicPlayerViewModel.songs) { song in
                SongItemView(musicPlayerViewModel: musicPlayerViewModel, song: song)
                
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(
                .init(top: 12, leading: 16, bottom: 12, trailing: 16)
            ))
        }
        .listStyle(.plain)
    }
}

#Preview {
    SongListView()
}
