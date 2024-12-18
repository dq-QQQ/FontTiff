//
//  FontComparisionView.swift
//  FontTiff
//
//  Created by dq on 12/17/24.
//

import SwiftUI

struct FontComparisionView: View {
    @AppStorage("customText") private var customText: String = "Hello SwiftUI!"
    @State private var isShowingFontDetail = false

    let baseFontName: String
    let comparisonFontName: (String, Bool)
    let originalFontName: String
    
    init(baseFontName: String, comparisonFontName: String, originalFontName: String) {
        self.baseFontName = baseFontName
        self.originalFontName = originalFontName
        if comparisonFontName == originalFontName {
            self.comparisonFontName = (comparisonFontName, true)
        } else {
            self.comparisonFontName = (comparisonFontName, false)
        }
        
    }
    
    var body: some View {
        HStack() {
            VStack {
                Text(originalFontName)
                    .frame(maxWidth: 200)
                    .padding()
                    .onTapGesture {
                        isShowingFontDetail = true
                    }
                    .sheet(isPresented: $isShowingFontDetail) {
                        FontDetailView(fontName: baseFontName, comparisonFontName: comparisonFontName.0)
                    }
                if comparisonFontName.1 == false{
                    Text("\(comparisonFontName.0)로 대체됨")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.orange)
                }
            }

            Divider()
            FontOverlayView(baseFontName: baseFontName, comparisonFontName: comparisonFontName.0)
            Spacer()
        }
    }
}

struct FontOverlayView: View {
    @AppStorage("customText") private var customText: String = "Hello SwiftUI!"
    @State private var overlayOpacity: Double = 0.5
    let baseFontName: String
    let comparisonFontName: String

    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .top) {
                Text("기준\n폰트")
                    .foregroundColor(.cyan)
                Spacer()
                ZStack {
                    Text(customText)
                        .font(.custom(baseFontName, size: 36))
                        .foregroundColor(.blue)
                    
                    Text(customText)
                        .font(.custom(comparisonFontName, size: 36))
                        .foregroundColor(.red)
                        .opacity(overlayOpacity)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                Spacer()
                Text("비교\n폰트")
                    .foregroundColor(.red)
            }
            VStack {
                Text("Overlay Opacity: \(String(format: "%.2f", overlayOpacity))")
                Slider(value: $overlayOpacity, in: 0...1)
            }
            .padding()
        }
        .padding()
    }
    
    
}



#Preview {
//    FontComparisionView(
}
