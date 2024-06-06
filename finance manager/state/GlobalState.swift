import SwiftUI
import Combine
import FirebaseFirestore

class GlobalState: ObservableObject {
    // MARK: - Published Properties
    
    
    
    @Published var selectedTab: TabType = .income
    @Published var selectedCurrency: String = ""
    @Published var isSearchActive: Bool = false
    @Published var filteredArray: [String: String] = [:]
    @Published var isLoggedIn: Bool = false
    @Published var isSignedUp: Bool = false
    @Published var isDrawerOpen: Bool = false
    @Published var isPasswordRestored: Bool = false
    @Published var currentScreen: Int = ScreenType.home.id
    @Published var incomeTotal: Double = 0.0
    @Published var expensesTotal: Double = 0.0
    @Published var listView: [String: [ListTileModel]] = [:]
    @Published private var balanceTotal: Double = 0.0
    @Published var userId: String?
    @Published var noteList: [NoteModal] = []
    
    func addToNotesList(tile: NoteModal) {
        noteList.append(tile)
    }
    
    func getPercentIncomeNote() -> Double {
        let total = incomeTotal + expensesTotal + balanceTotal
        return incomeTotal / total
    }
    
    func getPercentExpensesNote() -> Double {
        let total = incomeTotal + expensesTotal + balanceTotal
        return expensesTotal / total
    }
    
    // MARK: - Firestore
    
    private let db = Firestore.firestore()
    
    // MARK: - User Data Functions
    
    func getBalanceTotal() -> Double {
        return balanceTotal
    }
    
    func setInitialBalance(amount: String) {
        if let amount = Double(amount) {
            balanceTotal = amount
        }
    }
    
    func increaseBalance(amount: Double) {
        balanceTotal += amount
    }
    
    func decreaseBalance(amount: Double) {
        balanceTotal -= amount
    }
    
    func addIncome(_ amount: Double) {
        incomeTotal += amount
    }
    
    func addExpense(_ amount: Double) {
        expensesTotal += amount
    }
    
    func addListTile(for date: String, tile: ListTileModel) {
        if listView[date] != nil {
            listView[date]?.insert(tile, at: 0)
        } else {
            listView[date] = [tile]
        }
    }
    
    func appendFilteredArray(array: [String: String], searchedText: String) {
        filteredArray = array.filter { key, value in
            key.localizedLowercase.contains(searchedText.localizedLowercase) ||
            value.localizedLowercase.contains(searchedText.localizedLowercase)
        }
    }
    
    // MARK: - User Data Management Functions
    
    func createUserData(userId: String) async {
        let userDoc = db.collection("Users").document(userId)
        do {
            try await userDoc.setData([
                "balance": "0.0",
                "income": "0.0",
                "expenses": "0.0"
            ])
        } catch {
            print("Error creating user document or initializing list: \(error.localizedDescription)")
        }
    }
    
    func fetchAmounts() async {
        guard let userId = userId else {
            print("User ID is not set.")
            return
        }
        
        async let balanceTask: Void = fetchBalance(for: userId)
        async let incomeTask: Void = fetchIncome(for: userId)
        async let expensesTask: Void = fetchExpenses(for: userId)
        async let listTask: Void = fetchList(for: userId)
        async let notesTask: Void = fetchNotes(for: userId)
        
       await (balanceTask, incomeTask, expensesTask, listTask, notesTask)
    }
    
    func updateUserData() async {
        guard let userId = userId else {
            print("User ID is not set.")
            return
        }
        
        async let balanceTask: Void = updateBalance(for: userId)
        async let incomeTask: Void = updateIncome(for: userId)
        async let expensesTask: Void = updateExpenses(for: userId)
        async let listTask: Void = updateList(for: userId)
        async let notesTask: Void = updateNotes(for: userId)
        
       await (balanceTask, incomeTask, expensesTask, listTask, notesTask)
    }
    
    // MARK: - Firestore Functions
    
    private func fetchBalance(for userId: String) async {
        let balanceDoc = db.collection("Users").document(userId).collection("Balance").document("balanceDoc")
        do {
            let document = try await balanceDoc.getDocument()
            if let data = document.data(), let amount = data["balance"] as? String {
                DispatchQueue.main.async {
                    self.setInitialBalance(amount: amount)
                }
            }
        } catch {
            print("Error fetching balance: \(error.localizedDescription)")
        }
    }
    
    private func fetchIncome(for userId: String) async {
        let incomeDoc = db.collection("Users").document(userId).collection("Income").document("incomeDoc")
        do {
            let document = try await incomeDoc.getDocument()
            if let data = document.data(), let amount = data["income"] as? String {
                DispatchQueue.main.async {
                    self.incomeTotal = Double(amount) ?? 0.0
                }
            }
        } catch {
            print("Error fetching income: \(error.localizedDescription)")
        }
    }
    
    private func fetchExpenses(for userId: String) async {
        let expensesDoc = db.collection("Users").document(userId).collection("Expenses").document("expensesDoc")
        do {
            let document = try await expensesDoc.getDocument()
            if let data = document.data(), let amount = data["expenses"] as? String {
                DispatchQueue.main.async {
                    self.expensesTotal = Double(amount) ?? 0.0
                }
            }
        } catch {
            print("Error fetching expenses: \(error.localizedDescription)")
        }
    }
    
    private func fetchList(for userId: String) async {
        let listCollection = db.collection("Users").document(userId).collection("List")
        do {
            let snapshot = try await listCollection.getDocuments()
            for document in snapshot.documents {
                let dateID = document.documentID
                let subCollection = listCollection.document(dateID).collection("listTile")
                let subSnapshot = try await subCollection.getDocuments()
                for subDocument in subSnapshot.documents {
                    let listTileData = subDocument.data()
                    let amountValue = listTileData["amount"] as? String ?? ""
                    let amountDouble = Double(amountValue) ?? 0.0
                    let comment = listTileData["comment"] as? String ?? ""
                    let category = listTileData["category"] as? String ?? ""
                    let imageName = listTileData["iconName"] as? String ?? ""
                    let typeString: String = listTileData["type"] as? String ?? ""
                    let type: AmountType = typeString.lowercased() == "expense" ? .expense : .income
                    let newTile = ListTileModel(amount: amountDouble, comment: comment, category: category, image: imageName, type: type)
                    addListTile(for: dateID, tile: newTile)
                }
            }
        } catch {
            print("Error fetching list: \(error.localizedDescription)")
        }
    }
    
    // Inside the GlobalState class

    private func fetchNotes(for userId: String) async {
        let notesCollection = db.collection("Users").document(userId).collection("Notes")
        
        do {
            let snapshot = try await notesCollection.getDocuments()
            
            for document in snapshot.documents {
                let noteData = document.data()
                
                let text = noteData["text"] as? String ?? ""
                let category = noteData["category"] as? String ?? ""
                let isChecked = noteData["isChecked"] as? Bool ?? false
                
                let newNote = NoteModal(text: text, category: category, isChecked: isChecked)
                
                // Add the new note to the noteList
                DispatchQueue.main.async {
                    self.addToNotesList(tile: newNote)
                }
            }
        } catch {
            print("Error fetching notes: \(error.localizedDescription)")
        }
    }

    
    private func updateBalance(for userId: String) async {
        let balanceDoc = db.collection("Users").document(userId).collection("Balance").document("balanceDoc")
        do {
            try await balanceDoc.setData([
                "balance": String(balanceTotal)
            ], merge: true)
        } catch {
            print("Error updating balance: \(error.localizedDescription)")
        }
    }
    
    private func updateIncome(for userId: String) async {
        let incomeDoc = db.collection("Users").document(userId).collection("Income").document("incomeDoc")
        do {
            try await incomeDoc.setData([
                "income": String(incomeTotal)
            ], merge: true)
        } catch {
            print("Error updating income: \(error.localizedDescription)")
        }
    }
    
    private func updateExpenses(for userId: String) async {
        let expensesDoc = db.collection("Users").document(userId).collection("Expenses").document("expensesDoc")
        do {
            try await expensesDoc.setData([
                "expenses": String(expensesTotal)
            ], merge: true)
        } catch {
            print("Error updating expenses: \(error.localizedDescription)")
        }
    }
    
    private func updateList(for userId: String) async {
        let listCollection = db.collection("Users").document(userId).collection("List")
        
        do {
            // Loop through each dateID and its corresponding listTiles
            for (dateID, listTiles) in listView {
                // Reference to the date document
                let dateDocumentRef = listCollection.document(dateID)
                
                // Clear existing list tiles
                let existingListTiles = try await dateDocumentRef.collection("listTile").getDocuments()
                for document in existingListTiles.documents {
                    try await document.reference.delete()
                }
                
                // Ensure the date document exists
                try await dateDocumentRef.setData([:], merge: true)
                
                // Loop through each listTile and update it in Firestore
                for listTile in listTiles {
                    let tileData: [String: Any] = [
                        "amount": String(listTile.amount),
                        "comment": listTile.comment,
                        "category": listTile.category,
                        "iconName": listTile.image,
                        "type": listTile.type == .expense ? "expense" : "income"
                    ]
                    
                    // Convert UUID to string for use as document ID
                    let listTileDocumentRef = dateDocumentRef.collection("listTile").document(listTile.id.uuidString)
                    
                    // Add new document
                    try await listTileDocumentRef.setData(tileData)
                }
            }
        } catch {
            print("Error updating list: \(error.localizedDescription)")
        }
    }
    
    // Inside the GlobalState class

    private func updateNotes(for userId: String) async {
        let notesCollection = db.collection("Users").document(userId).collection("Notes")
        
        do {
            // Clear existing notes
            let existingNotes = try await notesCollection.getDocuments()
            for document in existingNotes.documents {
                try await document.reference.delete()
            }
            
            // Loop through each note and update it in Firestore
            for note in noteList {
                let noteData: [String: Any] = [
                    "text": note.text,
                    "category": note.category,
                    "isChecked": note.isChecked
                ]
                
                // Convert UUID to string for use as document ID
                let noteDocumentRef = notesCollection.document()
                
                // Add new document
                try await noteDocumentRef.setData(noteData)
            }
        } catch {
            print("Error updating notes: \(error.localizedDescription)")
        }
    }

}

