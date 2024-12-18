//
//  ContentView.swift
//  FontTiff
//
//  Created by dq on 12/16/24.
//

import SwiftUI

struct FontInfo: Codable {
    var fontNames: [String]
    let fontFilename: String
    
    enum CodingKeys: String, CodingKey {
        case fontNames = "font_names"
        case fontFilename = "font_filename"
    }
    
    
    func resetFontNames() -> (origin: [String], changed: [String]) {
        var ret = fontNames
        print("\n-------------------------------\n")
        isFontAvailable(fontName: getOnlyFontName())
        for i in 0..<fontNames.count {
            if !isFontAvailable(fontName: ret[i]) {
                ret[i] = getOnlyFontName()
            }
        }
        return (origin: fontNames, changed: ret)
    }

    
    func isFontAvailable(fontName: String) -> Bool {
        let ret = UIFont(name: fontName, size: 12) != nil
        
        if ret {
            print("\(fontName)은 존재하여 적용되었음")
        } else {
            print("\(fontName)은 존재하지 않아 대체되었음")
        }
        return UIFont(name: fontName, size: 12) != nil
    }
    
    func printAvailableFonts() {
        for family in UIFont.familyNames {
            print("Font Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("\(name)")
            }
        }
    }
    
    func getOnlyFontName() -> String {
        String(fontFilename.split(separator: "/").last?.split(separator: ".").first ?? "")
    }
}


class ContentViewModel: ObservableObject {
    @Published var fontInfos: [FontInfo] = []
    
    private func loadFontJson() -> String {
        guard let path = Bundle.main.path(forResource: "FontInfos", ofType: "json") else {
            return ""
        }
        guard let jsonStr = try? String(contentsOfFile: path, encoding: .utf8) else {
            return ""
        }
        return jsonStr
    }
    
    private func parseJson(_ str: String) {
        if let json = str.data(using: .utf8) {
            let info = try? JSONDecoder().decode([FontInfo].self, from: json)
            fontInfos = info ?? []
        }
    }
    
    func getFontInfo() {
        let jsonstr = loadFontJson()
        parseJson(jsonstr)
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State var flipValue = Double.zero
    var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.fontInfos, id: \.fontFilename) { fontInfo in
                NavigationLink(destination: ScrollView {FontListView(fontInfo: fontInfo)}.navigationTitle("dq's Font Tiff") ) {
                    Text(fontInfo.getOnlyFontName())
                        .foregroundColor(isFontAvailable(fontName: fontInfo.getOnlyFontName()) ? .cyan : .primary)
                }
            }
            .navigationTitle("폰트 종류")
        } detail: {
            HStack(spacing: 40){
                Group {
                    Text("비교하고\n싶은\n폰트를\n선택하세요")
                        .multilineTextAlignment(.leading)
                    Text("Select\nFont\nTo\nCompare")
                        .multilineTextAlignment(.trailing)
                }
                .font(.custom("Helvetica", size: 50))
                .tracking(10)
                .lineSpacing(30)
                .bold()
                .rotation3DEffect(.degrees(flipValue), axis: (x: 1, y: 0, z: 1))
                .animation(.default.delay(0.2), value: flipValue)
                .onReceive(timer, perform: { _ in
                    withAnimation {
                        flipValue += 180
                    }
                })
                .onDisappear {
                    timer.upstream.connect().cancel()
                }
            }
            
        }
        .navigationTitle("hohoho")
        .onAppear {
            viewModel.getFontInfo()
        }
    }
    
    
    func isFontAvailable(fontName: String) -> Bool {
        UIFont(name: fontName, size: 12) != nil
    }
}


#Preview {
    ContentView()
}
