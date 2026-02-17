//
//  Song.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import Foundation

struct Song: Identifiable {
    var id = UUID()
    var name: String
    var artist: String
    var imageName: String
}
