//
//  RowView.swift
//  IOSTask
//
//  Created by Farido on 14/09/2024.
//

import SwiftUI

struct RowView: View {
    let bug: BugsModel

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if let uiImage = UIImage(data: bug.bugImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            VStack(alignment: .leading) {
                Text(bug.bugTitle)
                Text(bug.bugDesc)
                    .lineLimit(2)
            }

            Spacer()
        }
        .background(
            Color.white.opacity(0.01)
        )
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(bug: BugsModel(bugTitle: "new title", bugDesc: "new desc", bugImage: Data()))
            .previewLayout(.sizeThatFits)
    }
}
