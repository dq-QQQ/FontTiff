//
//  ComparisionStringButton.swift
//  FontTiff
//
//  Created by dq on 12/17/24.
//

import SwiftUI
enum TextType: String, CaseIterable {
    case defaultText = "Hello World"

    case korean = """
가나다라마바사아자차카타파하
안녕하세요, 반갑습니다.
이 문장은 폰트의 가독성을 테스트하기 위해 작성되었습니다. 글자 간의 간격과 크기를 확인하세요.
"""

    case english = """
ABCDEFGHIJKLMNOPQRSTUVWXYZ
Hello, nice to meet you.
This sentence is written to test the readability of the font. Check the spacing and size of the characters.
"""

    case japanese = """
あいうえおかきくけこさしすせそ
こんにちは、はじめまして。
この文章はフォントの可読性をテストするために作成されました。文字間隔やサイズを確認してください。
"""

    case chinese = """
天地玄黄宇宙洪荒
你好，很高兴见到你。
这段文字是为了测试字体的可读性而创建的。请检查字符的间距和大小。
"""

    case empty = ""
}

extension TextType {
    var name: String {
        switch self {
        case .defaultText:
            return "Default"
        case .korean:
            return "Korean"
        case .english:
            return "English"
        case .japanese:
            return "Japanese"
        case .chinese:
            return "Chinese"
        case .empty:
            return "Empty"
        }
    }
}

struct ComparisionStringButton: View {
    @AppStorage("customText") private var customText: String = TextType.defaultText.rawValue
    @State var prevText: String = ""
    
    var body: some View {
        HStack {
            ForEach(TextType.allCases, id: \.self) { textType in
                Button(action: {
                    customText = textType.rawValue
                }) {
                    Text(textType.name.capitalized)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}
