//
//  FontDetailView.swift
//  FontTiff
//
//  Created by dq on 12/17/24.
//

import SwiftUI

struct FontMetrics {
    let fontName: String
    let familyName: String
    let pointSize: CGFloat
    let ascender: CGFloat
    let descender: CGFloat
    let lineHeight: CGFloat
    let capHeight: CGFloat
    let xHeight: CGFloat
    let leading: CGFloat

    static func getMetrics(for fontName: String, size: CGFloat = 16) -> FontMetrics? {
        guard let font = UIFont(name: fontName, size: size) else { return nil }
        return FontMetrics(
            fontName: font.fontName,
            familyName: font.familyName,
            pointSize: font.pointSize,
            ascender: font.ascender,
            descender: font.descender,
            lineHeight: font.lineHeight,
            capHeight: font.capHeight,
            xHeight: font.xHeight,
            leading: font.leading
        )
    }
}



struct FontDetailView: View {
    let fontName: String
    let comparisonFontName: String

    // 폰트 메트릭스 가져오기
    var baseFontMetrics: FontMetrics? {
        FontMetrics.getMetrics(for: fontName)
    }

    var comparisonFontMetrics: FontMetrics? {
        FontMetrics.getMetrics(for: comparisonFontName)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("폰트 정보")
                .font(.headline)
                .padding(.top)

            List {
                Section(header: FontMetricRow(title: "", value1: "기준폰트", value2: "비교폰트")) {
                    if let metrics = baseFontMetrics, let compare = comparisonFontMetrics {
                        FontMetricRow(title: "폰트 패밀리", value1: metrics.familyName, value2: compare.familyName)
                        FontMetricRow(title: "포인트 크기", value1: "\(metrics.pointSize)", value2: "\(compare.pointSize)")
                        FontMetricRow(title: "윗선(Ascender)", value1: "\(metrics.ascender)", value2: "\(compare.ascender)")
                        FontMetricRow(title: "아랫선(Descender)", value1: "\(metrics.descender)", value2: "\(compare.descender)")
                        FontMetricRow(title: "줄 높이(Line Height)", value1: "\(Int(metrics.lineHeight))", value2: "\(Int(compare.lineHeight))")
                        FontMetricRow(title: "대문자 높이(Cap Height)", value1: "\(metrics.capHeight)", value2: "\(compare.capHeight)")
                        FontMetricRow(title: "소문자 높이(x-Height)", value1: "\(metrics.xHeight)", value2: "\(compare.xHeight)")
                        FontMetricRow(title: "자간(Leading)", value1: "\(metrics.leading)", value2: "\(compare.leading)")

                    } else {
                        Text("Font metrics not available")
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .padding()
    }
}

struct FontMetricRow: View {
    let title: String
    let value1: String
    let value2: String

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value1)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
            Text(value2)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}


#Preview {
//    FontDetailView()
}
