//
//  ViewController.swift
//  pizzaOrderApp
//
//  Created by Yeibin Kang on 2021-10-17.
//

import UIKit

//pickerView
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: outlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var lblNumPizza: UILabel!
    @IBOutlet weak var lblReceipt: UILabel!
    @IBOutlet weak var lblR: UILabel!
    
    //MARK: variables
    let pizza = ["Spicy Pulled Pork Pizza", "Vegeterian Fiesta Pizza", "The Original"]
    
    let pizzaDescription = ["Slow-roasted pulled pork with a special spicy and smoky BBQ pizza sauce","Roasted red peppers, caramelized onions, sundried organic tomatoes, feta, and spinach, on a thin crust with pesto sauce", "Pepperoni, cheese, green onions. Served with extra tomato sauce and three types of cheese"]
    
    var pizzaPrice:Double = 17.50
    
    var selectedIndex:Int = 0
    
    
    var numOfPizza:Double = 1
    

    //MARK: functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.selectRow(2, inComponent: 0, animated: true)
    }
    
    //number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //total number of items
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pizza.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pizza[row]
    }


    @IBAction func selectedPizza(_ sender: Any) {
        
        selectedIndex = self.pickerView.selectedRow(inComponent: 0)
        lblDescription.text = "\(pizzaDescription[selectedIndex])"

        
    }
    
    //select a pizza size
    @IBAction func selectedSize(_ sender: Any) {
        print(segmentedControl.selectedSegmentIndex)
        var index = segmentedControl.selectedSegmentIndex
        
        switch index {
        case 0:
            pizzaPrice = 15.50
            break
        case 1:
            pizzaPrice = 17.50
            break
        case 2:
            pizzaPrice = 21.50
            break
        default:
            print("")
        }
    }
    
    //select a quantity of pizza
    @IBAction func stepperChanged(_ sender: Any) {
        print(myStepper.value)
        
        lblNumPizza.text = String(Int(myStepper.value))
        
        numOfPizza = Double(myStepper.value)
        
    }
    
    //place order button function - receipt
    @IBAction func placeOrderPressed(_ sender: Any) {
        
        //make an alert box
        let alertBox = UIAlertController(title: "Order confirmation", message: "Are you sure you are ready to place this order?", preferredStyle: .alert)
        
        //add buttons
        alertBox.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))
        
        alertBox.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self]
            action in
            
            //fill out the receipt
    
            lblR.text = "Receipt"
            
            var tempString:String = ""
            
            //num of pizza
            tempString += self.lblNumPizza.text ?? "0"
            
            tempString += " "
            
            //size of pizza
            tempString += self.segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? ""
            
            tempString += ", "
            
            tempString += pizza[selectedIndex]
            
            tempString += " \n"
            
            
            tempString += "Subtotal: "
            
            //calculate the price
            var price:Double = numOfPizza * pizzaPrice
            print(price)
            print(numOfPizza)
            print(pizzaPrice)
            
            var HST = (price*0.13)
           pow(HST,2)
            
            var totalPrice = price+HST
            
            //print the price
            tempString += "$\(price) \n"
            tempString += "Tax: $\(HST) \n"
            tempString += "Final total: $\(totalPrice)"
            

            self.lblReceipt.text = tempString
            

        }))
        
        
        
        
        self.present(alertBox, animated: true)
        
    }
    
    //restart the application
    @IBAction func startOver(_ sender: Any) {
        
        //pizza
        pickerView.selectRow(2, inComponent: 0, animated: true)
        
        //description
        lblDescription.text = ""
        
        //size
        segmentedControl.selectedSegmentIndex = 1
        
        //stepper
        myStepper.value = 1
        
        //num
        lblNumPizza.text = "1"
        
        
        //receipt
        lblReceipt.text = ""
        
    }
    
}

