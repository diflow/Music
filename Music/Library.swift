//
//  Library.swift
//  Music
//
//  Created by ivan on 24.12.2020.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var body: some View {
        NavigationView{
            VStack(spacing: 25) {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            print("12321")
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.8717951526, green: 0.8717951526, blue: 0.8717951526, alpha: 1)))
                                .cornerRadius(10)
                        })
                        Button(action: {
                            print("567568")
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.8717951526, green: 0.8717951526, blue: 0.8717951526, alpha: 1)))
                                .cornerRadius(10)
                        })
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                //Spacer()
//                    List {
//                        ForEach(tracks) { track in
//                            LibraryCell(cell: track).gesture(LongPressGesture().onEnded({ _tracks in
//                                print("Pressed")
//                                self.track = track
//                                self.showingAlert = true
//                            }))
//                        }.onDelete(perform: delete)
//                }
                List(tracks) { track in
                        LibraryCell(cell: track).gesture(LongPressGesture().onEnded({ _tracks in
                            print("Pressed")
                            self.track = track
                            self.showingAlert = true
                        }))
            }
                
            }.actionSheet(isPresented: self.$showingAlert, content: {
                ActionSheet(title: Text("Are you sure you want to delete this track?"),
                            buttons: [.destructive(Text("Delete"), action: {
                                print("Deleting: \(self.track.trackName)")
                                self.delete(track: self.track)
                            }), .cancel()])
            })
                .navigationBarTitle("Library")
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}


struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(url: URL(string: cell.iconUrlString ?? "")!, content: { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
                    //.aspectRatio(contentMode: .fit)
            })
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
        
    }
}

//struct Library_Previews: PreviewProvider {
//    static var previews: some View {
//        Library()
//    }
//}
