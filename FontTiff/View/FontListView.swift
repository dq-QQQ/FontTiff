//
//  FontComparisionView.swift
//  FontTiff
//
//  Created by dq on 12/16/24.
//

import SwiftUI

struct FontListView: View {
    @AppStorage("customText") private var customText: String = "Hello, SwiftUI!"
    var fontInfo: FontInfo
    
    var body: some View {
        VStack() {
            
            TextEditor(text: $customText)
                .frame(minHeight: 50)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            ComparisionStringButton()
            
            
            ForEach(Array(fontInfo.resetFontNames().changed.enumerated()), id: \.offset) { index, font in
                FontComparisionView(
                    baseFontName: fontInfo.getOnlyFontName(),
                    comparisonFontName: font,
                    originalFontName: fontInfo.fontNames[index]
                )
                Divider()
            }
        }
        .padding()
    }
}


#Preview {
//    FontListView(fontInfo: FontInfo(fontNames: ["hoho1", "hoho2", "hoho3", "hoho4", "hoho5"], fontFilename: "hoho"))
}
