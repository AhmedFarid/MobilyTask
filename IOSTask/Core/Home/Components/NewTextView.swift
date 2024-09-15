//
//  NewTextView.swift
//  IOSTask
//
//  Created by Farido on 15/09/2024.
//

import SwiftUI

struct NewTextView: View {
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text("Write something...")
                        .padding()
                        .opacity(1.0)
                    Spacer()
                }
            }

            VStack {
                TextEditor(text: $text)
                    .padding()
                    .frame(height: 100)
                    .opacity(text.isEmpty ? 0.85 : 1)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1.0)
                    }
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    NewTextView(text: .constant(""))
}
