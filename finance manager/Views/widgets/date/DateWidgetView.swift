//
//  DateWidgetView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
//

import SwiftUI

struct DateWidgetView: View {
    @EnvironmentObject var state: GlobalState
    @State private var isDatePickerVisible = true
    @State private var pickedDate: Date = Date.now
    @State var id: Int = 0
    @Binding var selectedDate: String
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text(todayDate)
                    .font(.headline)
                    .padding(.top, 10)
                Text(todayString)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
            }
            .background(id == 0 ? Color.datePick : nil)
            .onTapGesture {
                id = 0
                selectedDate = formattedDate(from: Date.now, dateType: .yearMonthDay, dayType: .today)
            }
            VStack {
                Text(yesterdayDate)
                    .font(.headline)
                    .padding(.top, 10)
                Text(yesterdayString)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
            }
            .background(id == 1 ? Color.datePick : nil)
            .onTapGesture {
                id = 1
                selectedDate = formattedDate(from: Date.now, dateType: .yearMonthDay, dayType: .yesterday)
            }
            DatePicker("Select a day", selection: $pickedDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.automatic)
                .labelsHidden()
                .frame(maxHeight: 20)
                .onChange(of: pickedDate) {
                    selectedDate = formattedDate(from: pickedDate, dateType: .yearMonthDay, dayType: nil)
                    id = 3
                }
            // instead of date picker i want icon calendar to be shown
            
        }
    }
}
