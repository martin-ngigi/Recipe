/*
* Created by Martin Wainaina on 17/09/2026
*
* Feel free to contribute.
*/

//
//  StructuralAPIsView.swift
//  Recipe
//
//  Created by RAFIKI on 16/09/2026.
//

import SwiftUI

struct StructuralAPIsView: View {
    
    @State var isShowInspector = false
    @State var isShowSheet = false
    @State var isShowPopover = false
    @State var isShowAlert = false
    @State var isShowConfirmDialog = false
    
    var body: some View {
        VStack(spacing: 36){
            Button("Show Inspector"){
                isShowInspector.toggle()
            }
            .buttonStyle(.glass)
            
            Button("Show Sheet"){
                isShowSheet.toggle()
            }
            .buttonStyle(.glass)
            
            Button("Show Popover"){
                isShowPopover.toggle()
            }
            .buttonStyle(.glass)
            .popover(isPresented: $isShowPopover) {
                Text("Popover View")
                    .padding()
            }
            
            Button("Show Alert"){
                isShowAlert.toggle()
            }
            .buttonStyle(.glass)
            .alert("Are you sure?", isPresented: $isShowAlert) {
                Button("Delete", role: .destructive) {}
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This action cannot be undone.")
            }
            
            Button("Show Confirmation Dialog"){
                isShowConfirmDialog.toggle()
            }
            .buttonStyle(.glass)
            .confirmationDialog(
                "Are you sure you want to empty the trash?",
                isPresented: $isShowConfirmDialog,
                titleVisibility: .visible
            ) {
                Button("Empty Trash", role: .destructive) {}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action cannot be undone.")
            }
        }
        .inspector(isPresented: $isShowInspector) {
            InspectorView()
                .inspectorColumnWidth(min: 200, ideal: 300, max: 400)
        }
        .sheet(isPresented: $isShowSheet) {
            Text("Sheet View")
        }
        .toolbar{
            Button{
                isShowInspector.toggle()
            } label: {
                Image(systemName: "info.circle")
            }
        }
        
    }
}

struct InspectorView: View {
    var body: some View {
        VStack(spacing: 36){
            Text("Inspector View")
        }
    }
}

#Preview {
    NavigationStack{
        StructuralAPIsView()
    }
}
