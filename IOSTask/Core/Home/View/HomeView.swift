//
//  HomeView.swift
//  IOSTask
//
//  Created by Farido on 14/09/2024.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel

    @State private var isOpenNewBug: Bool = false
    @State private var showDetailsView: Bool = false
    @State private var selectedBug: BugsModel? = nil

    var body: some View {
        NavigationStack {
            homeHeader
            allList
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

extension HomeView {
    private var allList: some View {
        List {
            ForEach(vm.allBugs) { bug in
                RowView(bug: bug)
                    .onTapGesture {
                        segue(bug: bug)
                    }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let bug = vm.allBugs[index]
                    vm.updateBug(bug: bug, isDelete: true)
                }

            }
            .listStyle(.plain)
        }
        .navigationDestination(isPresented: $showDetailsView) {
            AddNewView(bug: $selectedBug)
        }
    }

    private func segue(bug: BugsModel) {
        selectedBug = bug
        showDetailsView.toggle()
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            NavigationStack {
                VStack {
                    NavigationLink {
                        AddNewView(bug: .constant(nil))
                            .environmentObject(vm)
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .frame(width: 25, height: 25)
                            .background(
                                Circle()
                                    .foregroundStyle(.white)
                            )
                            .shadow(radius: 10)
                    }
                }
            }

            Spacer()
            Text("Bug It")
                .font(.headline)

            Spacer()

            Image(systemName: "")
                .frame(width: 25, height: 25)

        }
        .padding(.horizontal)
    }
}
