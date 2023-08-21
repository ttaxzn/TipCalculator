//
//  ContentView.swift
//  TipCalculator
//
//  Created by Tea Abuselidze on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel){
        self.viewModel = viewModel
    }
    
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        Form{
            Text("Tip Calculator").font(.title)
            
            Section(header: Text("Enter Your Bill Information")) {
                CurrencyField(
                    "Enter bill cost", value: Binding(get: {
                        viewModel.amount.map{ NSDecimalNumber(decimal: $0) }
                    }, set: { number in viewModel.amount = number?.decimalValue })
                )
            }
            
            Section(header: Text("Select Your Career")) {
                Picker("Career", selection: $viewModel.selectedTipIndex) {
                    ForEach(0..<viewModel.tipPercentages.count, id: \.self) { index in
                        Text(viewModel.tipPercentages[index].career).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }

            
            Section(header: Text("To Pay:")) {
                Text("Tip Percentage: \(NSDecimalNumber(decimal: viewModel.tipPercentages[viewModel.selectedTipIndex].tipPercentage).doubleValue, specifier: "%.2f")%")


                Text("Tip to Pay: \(currencyFormatter.string(from: viewModel.tip ?? 0) ?? "0")")
                Text("Total to Pay: \(currencyFormatter.string(from: viewModel.toPay ?? 0) ?? "0")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
