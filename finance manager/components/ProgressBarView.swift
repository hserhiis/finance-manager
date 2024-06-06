import SwiftUI

struct ProgressBarView: View {
    @EnvironmentObject var state: GlobalState
    

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(lineWidth: 24)
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)

            // Gradient overlay
            Circle()
                .stroke(lineWidth: 0.34)
                .frame(width: 175, height: 175)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
                .overlay(content: {
                    Circle()
                        .stroke(.black.opacity(0.1), lineWidth: 2)
                        .blur(radius: 5)
                        .mask {
                            Circle()
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                })

            // Income segment
            Circle()
                .trim(from: 0, to: CGFloat(state.getPercentIncomeNote()))
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .butt))
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: -90))
                .foregroundColor(.green)
                .animation(.linear(duration: 1), value: state.getPercentIncomeNote())

            // Expenses segment
            Circle()
                .trim(from: CGFloat(state.getPercentIncomeNote()), to: CGFloat(state.getPercentIncomeNote() + state.getPercentExpensesNote()))
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .butt))
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: -90))
                .foregroundColor(.red)
                .animation(.linear(duration: 1), value: state.getPercentExpensesNote())

            // Balance segment
            Circle()
                .trim(from: CGFloat(state.getPercentIncomeNote() + state.getPercentExpensesNote()), to: 1)
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .butt))
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: -90))
                .foregroundColor(.blue)
                .animation(.linear(duration: 1), value: state.getPercentIncomeNote() + state.getPercentExpensesNote())

            // Display total income
            VStack {
                Text("Balance")
                Text("\(removeCommasAndDots(from: state.getBalanceTotal().short)) \(state.selectedCurrency)")
                    .foregroundStyle(Color.blue)
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.white)
            }
            
        }
    }
}
