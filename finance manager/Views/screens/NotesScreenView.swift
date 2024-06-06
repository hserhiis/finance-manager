import SwiftUI

struct NotesScreenView: View {
    @EnvironmentObject var globalState: GlobalState
    @State private var showModal = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .trailing) {
                List {
                    ForEach(globalState.noteList, id: \.id) { note in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(note.category)
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Text(note.text)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.textField)
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    if let index = globalState.noteList.firstIndex(where: { $0.id == note.id }) {
                                        globalState.noteList[index].isChecked.toggle()
                                        print(globalState.noteList[index].isChecked)
                                    }
                                }) {
                                    Image(systemName: note.isChecked ? "checkmark.square.fill" : "square")
                                        .foregroundColor(note.isChecked ? .green : .gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = globalState.noteList.firstIndex(where: { $0.id == note.id }) {
                                    globalState.noteList.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .padding()
            }
            .background(Color.backgroundBlack)
            
            // Position the NoteButton on top of the ZStack, aligned to the bottom-right corner
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NoteButton(showModal: $showModal)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 20))
            }
        }
    }
}

struct NoteButton: View {
    @Binding var showModal: Bool
    
    var body: some View {
        Button(action: {
            showModal = true
        }, label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(Color.red)
        })
        .sheet(isPresented: $showModal) {
            SheetView()
        }
        .background(Color.clear) // Ensure the button has a clear background
    }
}

struct SheetView: View {
    @State private var text: String = ""
    @State private var category: String = ""
    @EnvironmentObject var state: GlobalState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            TextFieldCustomView(text: $text, placeholder: "Enter Note")
            TextFieldCustomView(text: $category, placeholder: "Enter Category")
            Spacer()
            HStack {
                Spacer()
                ClearNoteButton {
                    dismiss()
                }
                AddNoteButton() {
                    let newNoteTile = NoteModal(text: text, category: category, isChecked: false)
                    state.addToNotesList(tile: newNoteTile)
                    dismiss()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 10))
        }
        .background(Color.backgroundBlack)
    }
}
