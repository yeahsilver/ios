//
//  TrackManager.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation // 미디어 관련 객체를 가지고 있음.

class TrackManager {
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        // let playerItem = AVPlayerItem(url: URL)
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }

    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        // 파일들을 읽어서 AVPlayerItem 만들기
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        
//        var items: [AVPlayerItem] = []
//        for url in urls {
//            let item = AVPlayerItem(url: <#T##URL#>)
//            items.append(item)
//        }
//       let item = AVPlayerItem(url: URL)
        
        // 위의 코드와 동일한 기능
        let items = urls.map{url -> AVPlayerItem in
            return AVPlayerItem(url:url)
        }
        
        // 위의 코드와 동일한 기능
//        let items = urls.map{ AVPlayerItem(url: $0) }
    
        return items
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        let track = playerItem.convertToTrack()
        
        return track
    }

    // TODO: 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList:[Track] = tracks.compactMap{ $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList, by: { (track) in track.albumName})
        var albums: [Album] =  []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks:tracks)
            albums.append(album)
        }
        return albums
    }

    // TODO: 오늘의 트랙 랜덤으로 선책
    func loadOtherTodaysTrack() {
        self.todaysTrack = self.tracks.randomElement()
    }
}
