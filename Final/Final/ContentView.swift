//
//  ContentView.swift
//  Final
//
//  Created by raegan morales on 4/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    PlaylistView()
                        .padding()
                    Spacer()
                }
                .navigationBarTitle("sound scape ☊")
            }
            .tabItem {
                                   Image(systemName: "music.note")
                                   Text("Playlist")
                               }

            MusicPlayerView()
            .tabItem {
                Image(systemName: "play.circle.fill")
                Text("Player")
            }
            
            SocialView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Social")
                }
            ArtistDiscoveryView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
        }
    }
}

struct Playlist: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct PlaylistView: View {
    let playlists: [Playlist] = [
        Playlist(name: "chill", imageName: "chill"),
        Playlist(name: "gym", imageName: "gym"),
        Playlist(name: "summer", imageName: "summer"),
        Playlist(name: "party", imageName: "party"),
        Playlist(name: "everyday", imageName: "everyday"),
        Playlist(name: "throwback", imageName: "throwback"),
        Playlist(name: "road trip", imageName: "roadtrip"),
        Playlist(name: "love", imageName: "love2"),
        
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 30) {
                    ForEach(playlists) { playlist in
                        NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
                            VStack {
                                Image(playlist.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 100)
                                    .cornerRadius(10)
                                
                                Text(playlist.name)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Playlists", displayMode: .inline) // Set display mode to inline
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "plus")
            })
        }
    }
}

struct PlaylistDetailView: View {
    let playlist: Playlist
    var body: some View {
        VStack {
            Image(playlist.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding()
            
            Text("Sorrows - Bryson Tiller")
                .frame(maxWidth: .infinity, alignment: .leading) // left align
                .padding([.bottom, .leading], 20)
             
               
            Text("Liability - Drake")
                .frame(maxWidth: .infinity, alignment: .leading) // left align
                .padding([.bottom, .leading], 20)
               
            
            Text("Homebody - Juto")
                .frame(maxWidth: .infinity, alignment: .leading) // left align
                .padding([.bottom, .leading], 20)
              
               
            Text("Static - Steve Lacy")
                .frame(maxWidth: .infinity, alignment: .leading) // left align
                .padding([.bottom, .leading], 20)
              
            
            Text("Awkward - SZA")
                .frame(maxWidth: .infinity, alignment: .leading) // left align
                .padding([.bottom, .leading], 20)
               
            
        }
        .navigationBarTitle(playlist.name)
    }
}


struct MusicPlayerView: View {
    @State private var currentSongIndex = 0
    @State private var currentTime: Double = 0
    @State private var totalTime: Double = 100 // Total time of the song (for demonstration)
    
    let songs: [Song] = [
        Song(title: "Jealous", artist: "Future, Metro Boomin", imageName: "trust"),
        Song(title: "Linger", artist: "The Cranberries", imageName: "linger"),
        Song(title: "Broken Clock", artist: "SZA", imageName: "ctrl"),
        Song(title: "Pipe Down", artist: "Drake", imageName: "clb"),
        Song(title: "And This is Just The Intro", artist: "Tory Lanez", imageName: "tory"),
        Song(title: "For However Long", artist: "Bryson Tiller", imageName: "trapsoul"),
        Song(title: "Pyramids", artist: "John Lennon", imageName: "orange"),
        
    ]
    
    var currentSong: Song {
        songs[currentSongIndex]
    }
    
    var body: some View {
        VStack {
            Image(currentSong.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding()
            
            Spacer().frame(height: 20) // Add space below the image
            
            Text(currentSong.title)
                .font(.title)
            
            Text(currentSong.artist)
                .font(.headline)
                
            
            HStack {
                Button(action: {
                    skipBackward()
                }) {
                    Image(systemName: "backward.fill")
                        .font(.title)
                }
                .padding()
                
                Button(action: {
                    // Action for pausing
                    // You can handle pausing logic here
                }) {
                    Image(systemName: "pause.circle.fill")
                        .font(.title)
                }
                .padding()
                
                Button(action: {
                    skipForward()
                }) {
                    Image(systemName: "forward.fill")
                        .font(.title)
                }
                .padding()
            }
            
            Slider(value: $currentTime, in: 0...totalTime, step: 1)
                .padding()
            
            HStack {
                Text("\(formatTime(currentTime))")
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("\(formatTime(totalTime))")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
        }
    }
    
    func skipBackward() {
        if currentSongIndex > 0 {
            currentSongIndex -= 1
        } else {
            // If already at the first song, loop back to the last song
            currentSongIndex = songs.count - 1
        }
    }
    
    func skipForward() {
        if currentSongIndex < songs.count - 1 {
            currentSongIndex += 1
        } else {
            // If already at the last song, loop back to the first song
            currentSongIndex = 0
        }
    }
}

func formatTime(_ time: Double) -> String {
    // Format time into minutes and seconds
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}

struct Song {
    let title: String
    let artist: String
    let imageName: String
}

struct SocialView: View {
    @State private var posts: [SocialPost] = [
        SocialPost(username: "kay_kay", songTitle: "Heyy", artistName: "Lil Baby", likes: 10, comments: ["heyyyyyyyy", "love this song omg"]),
        SocialPost(username: "alexisss", songTitle: "Throw Away", artistName: "Future", likes: 5, comments: ["ur going thru it lol"]),
        SocialPost(username: "raes_tunes", songTitle: "Phases", artistName: "Blaize Jenkins", likes: 5, comments: ["dude i love this song!"])
    ]
    
    @State private var newPostSongTitle = ""
    @State private var newPostArtistName = ""
    @State private var isPosting = false
    @State private var expandedPost: SocialPost?
    @State private var newCommentText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(posts.indices, id: \.self) { index in
                        let post = posts[index]
                        NavigationLink(destination: CommentView(comments: self.$posts[index].comments, newCommentText: $newCommentText, addCommentAction: {
                            let newComment = self.newCommentText
                            if !newComment.isEmpty {
                                self.posts[index].comments.append(newComment)
                                self.newCommentText = ""
                            }
                        })) {
                            SocialPostView(post: post)
                        }
                    }
                }
                
                Divider()
                
                if isPosting {
                    HStack {
                        TextField("Song Title", text: $newPostSongTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        TextField("Artist Name", text: $newPostArtistName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        Button(action: {
                            let newPost = SocialPost(username: "User", songTitle: newPostSongTitle, artistName: newPostArtistName, likes: 0, comments: [])
                            posts.append(newPost)
                            newPostSongTitle = ""
                            newPostArtistName = ""
                            isPosting.toggle()
                        }) {
                            Text("Post")
                        }
                        .padding()
                        
                        Button(action: {
                            isPosting.toggle()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                    .padding(.vertical)
                } else {
                    Button(action: {
                        isPosting.toggle()
                    }) {
                        Text("Create Post")
                    }
                    .padding()
                }
            }
            .navigationBarTitle("friends ❤︎")
        }
    }
}

struct SocialPostView: View {
    let post: SocialPost
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(post.username) is listening to:")
                .font(.headline)
            
            Text("\(post.songTitle) by \(post.artistName)")
            
            HStack {
                Image(systemName: "heart.fill")
                Text("\(post.likes)")
                
                Spacer()
                
                Image(systemName: "bubble.left")
                Text("\(post.comments.count)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding()
    }
}

struct CommentView: View {
    @Binding var comments: [String]
    @Binding var newCommentText: String
    var addCommentAction: () -> Void
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            ForEach(comments, id: \.self) { comment in
                HStack {
                    Spacer() // Add spacer to push the comment to the trailing edge
                    
                    Text(comment)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray)
                        )
                }
                .padding(.horizontal)
            }
            
            Divider()
            
            HStack {
                TextField("Add a comment", text: $newCommentText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    addCommentAction()
                }) {
                    Text("Post")
                }
                .padding()
            }
            .padding(.vertical)
        }
        .padding()
    }
}

struct SocialPost: Identifiable, Equatable {
    let id = UUID()
    let username: String
    let songTitle: String
    let artistName: String
    var likes: Int
    var comments: [String]
}


struct ArtistDiscoveryView: View {
    let topNewArtists: [Artist] = [
        Artist(name: "Future", image: "future", topSongs: ["1. Like That", "2. Type Sh*t", "3. Cinderella", "4. Too Many Nights (feat. Don Toliver)", "5. We Still Don't Trust You"]),
        Artist(name: "Drake", image: "drake", topSongs: ["1. One Dance", "2. Rich Baby Daddy (feat. Sexyy Red & SZA", "3. IDGAF (feat. Yeat)", "4. act ii: date @8 (feat. Drake)", "5. Push Ups"]),
        Artist(name: "Frank Ocean", image: "frank", topSongs: ["1. Pink + White", "2. Thinkin Bout You", "3. Lost", "4. Ivy", "5. Novacane"]),
        Artist(name: "SZA", image: "sza", topSongs: ["1. Saturn", "2. Snooze", "3. Kill Bill", "4. Rich Baby Daddy (feat. Sexyy Red, Drake", "5. All The Stars"]),
        Artist(name: "Steve Lacy", image: "steve", topSongs: ["1. Dark Red", "2. Bad Habit", "3. Some", "4. C U Girl", "5. Infrunami"]),
        Artist(name: "Brent Faiyaz", image: "brent", topSongs: ["1. Best Time", "2. Clouded", "3. Poison", "4. Trust", "5. Been Away"]),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 30) {
                    ForEach(topNewArtists) { artist in
                        NavigationLink(destination: ArtistDetailView(artist: artist)) {
                            VStack {
                                Image(artist.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 130)
                                    .cornerRadius(10)
                                
                                Text(artist.name)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("discover ✪")
        }
    }
}

struct ArtistDetailView: View {
    let artist: Artist
    
    var body: some View {
        VStack {
            Image(artist.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            
            Text(artist.name)
                .font(.headline)
            
            Text("Top 5 Songs:")
                .font(.title)
                .padding()
            
            ForEach(artist.topSongs, id: \.self) { song in
                Text(song)
                    .padding([.bottom, .leading], 20)
                    .frame(maxWidth: .infinity, alignment: .leading) // Align the text to the leading edge
            }
            
            Spacer()
        }
        .navigationBarTitle(artist.name)
    }
}


struct Artist: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let topSongs: [String]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
