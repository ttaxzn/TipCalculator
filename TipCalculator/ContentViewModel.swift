import Combine
import Foundation

class ContentViewModel: ObservableObject {
    
    // Output
    @Published var tip: NSDecimalNumber?
    @Published var toPay: NSDecimalNumber?
    
    // Input
    @Published var amount: Decimal?
    @Published var selectedTipIndex = 0
    @Published var myTwoCents: String = ""
    @Published var dineInSelection: Int = 0
    @Published var carryOutSelection: Int = 0
    @Published var curbsidePickupSelection: Int = 0
    @Published var deliverySelection: Int = 0
    @Published var minimumWageAgreement: Bool = false
    
    let tipPercentages: [TipPercentage] = [
        TipPercentage(career: "Waitress", tipPercentage: 19),
        TipPercentage(career: "Bartender", tipPercentage: 10)
    ]
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $amount
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
        
        $selectedTipIndex
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
    }
    
    func calculateTip() {
        guard let amount = amount else {
            return
        }
        let tipPercentageDecimal = tipPercentages[selectedTipIndex].tipPercentage / 100
        let tipValue = amount * tipPercentageDecimal
        tip = NSDecimalNumber(decimal: tipValue)
        toPay = NSDecimalNumber(decimal: amount + tipValue)
    }
}

struct TipPercentage {
    let career: String
    let tipPercentage: Decimal
}
