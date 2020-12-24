//
//  Library.swift
//  Music
//
//  Created by ivan on 24.12.2020.
//

import SwiftUI
import URLImage

struct Library: View {
    
    var tracks = UserDefaults.standard.savedTracks()
    
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
                                .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .cornerRadius(10)
                        })
                        Button(action: {
                            print("567568")
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .cornerRadius(10)
                        })
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                //Spacer()
                GeometryReader { geometry in
                    List(tracks) { track in
                        LibraryCell(cell: track)
                        
                    }
                }
                
            }
            
                .navigationBarTitle("Library")
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
            //Image("play").resizable().frame(width: 60, height: 60).cornerRadius(2)
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
