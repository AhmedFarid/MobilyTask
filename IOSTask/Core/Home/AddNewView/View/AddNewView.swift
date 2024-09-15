//
//  AddNewView.swift
//  IOSTask
//
//  Created by Farido on 15/09/2024.
//

import SwiftUI

struct AddNewView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @Binding var bug: BugsModel?

    @State private var textTitle: String = ""
    @State private var descText: String = ""

    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    @Environment(\.dismiss) var dissmiss

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                addNewImage
                addNewText
                NewTextView(text: $descText)
                saveButton
            }
            .navigationTitle(bug == nil ? "Add new bug" : bug?.bugTitle ?? "")
        }
        .onAppear {
            if bug != nil {
                self.textTitle = bug?.bugTitle ?? ""
                self.descText = bug?.bugDesc ?? ""
                if let data = bug?.bugImage, let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                    self.inputImage = uiImage
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddNewView(bug: .constant(nil))
    }
}

// add new image or load image
extension AddNewView {
    var addNewImage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1.0)
                .frame(height: 300)
                .padding()
                .foregroundStyle(.clear)

            if image != nil {
                image?
                    .resizable()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()

            } else {
                VStack {
                    Image(systemName: "plus")
                        .foregroundStyle(.green)
                        .frame(width: 50, height: 50)
                        .background(
                            Circle()
                                .stroke(.green, lineWidth: 1.0)
                                .foregroundStyle(.clear)
                        )

                    Text("Add screen shot of bug")
                        .font(.headline)
                }
            }
        }
        .onTapGesture {
            self.showingImagePicker = true
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

// add text input
extension AddNewView {
    var addNewText: some View {
        VStack {
            TextField("Add Bug title", text: $textTitle)
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1.0)
                })
        }
        .padding()
    }
}

// add the save button
extension AddNewView {
    var saveButton: some View {
        Text(bug == nil ? "Save" : "Update")
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.blue)
            )
            .padding()
            .onTapGesture {
                // save to data base
                if let data = self.inputImage?.jpegData(compressionQuality: 0.5) {
                    if bug == nil {
                        vm.updateBug(bug: BugsModel(bugTitle: textTitle, bugDesc: descText, bugImage: data), isDelete: false)
                    } else {
                        vm.updateBug(bug: BugsModel(id: bug?.id ?? "", bugTitle: textTitle, bugDesc: descText, bugImage: data), isDelete: false)
                    }
                    dissmiss()
                }
            }
    }
}
