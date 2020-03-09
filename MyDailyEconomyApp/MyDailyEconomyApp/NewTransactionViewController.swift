//
//  NewTransactionViewController.swift
//  MyDailyEconomyApp
//
//  Created by Ricardo González Pacheco on 06/03/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController{

    var button = DropDownBtn()
    var currencyButton = CurrencyButton()
    var delegate: TransactionAddedProtocol?
    
    var updateTotal: (() -> Void)?
    
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var descrip: UITextField!
    @IBOutlet weak var newStack: UIStackView!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Init category button
        
        button = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: catLabel.rightAnchor, constant: 165).isActive = true
        button.centerYAnchor.constraint(equalTo: catLabel.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 187).isActive = true
        
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5.0
        button.setTitleColor(.darkGray, for: .normal)
        button.dropView.tableView.backgroundColor = UIColor.clear
        button.dropView.dropDownOption = ["Salary", "Bet earnings", "Clothes sales", "Flat renting", "Food", "Car maintenance", "Party expenses"]
        
        
        button.amountDis = {() -> Void in
            self.amount.isHidden = true
            self.date.isHidden = true
            self.currencyButton.isHidden = true
            self.currencyButton.currencyDropDownView.isHidden = true
        }
        button.amountEna = {() -> Void in
            self.amount.isHidden = false
            self.date.isHidden = false
            self.currencyButton.isHidden = false
            self.currencyButton.currencyDropDownView.isHidden = false
        }
        
        // MARK: - Init currency button
        
        amount.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        currencyButton = CurrencyButton.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        //currencyButton.setTitle("€", for: .normal)
        currencyButton.translatesAutoresizingMaskIntoConstraints = false
        

        self.view.addSubview(currencyButton)
        currencyButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        currencyButton.centerYAnchor.constraint(equalTo: amount.centerYAnchor).isActive = true
        currencyButton.centerXAnchor.constraint(equalTo: amount.rightAnchor, constant: 68).isActive = true
        
        currencyButton.backgroundColor = UIColor.white
        currencyButton.layer.cornerRadius = 5.0
        currencyButton.setTitleColor(.darkGray, for: .normal)
        currencyButton.currencyDropDownView.tableView.backgroundColor = UIColor.clear
        currencyButton.currencyDropDownView.currencyList = ["€", "$", "₿"]
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func insertButton(_ sender: Any) {
        
        
        if(button.titleLabel?.text == "" || amount.text == "" || currencyButton.titleLabel?.text == "" || date.text == "" || descrip.text == "") {
            
        } else {
        
        
        
        var transaction: AccountTransaction?
        
        var currency: Currency = .EUR
        switch currencyButton.titleLabel?.text {
        case "$":
            currency = .USD
        case "₿":
            currency = .BTC
        default:
            print("")
        }
        
        var doubleAmount: Double = 0
        
        if let doubleValue = Double(amount.text!) {
            doubleAmount = doubleValue
        } else {
            print("Not a valid number: \(amount.text!)")
        }
        
        switch button.titleLabel?.text {
            case "Salary":
                transaction = AccountTransaction.salaryTransaction(value: Value.init(amount: doubleAmount, currency: currency), date: date.text ?? "No valid date", description: descrip.text ?? "No valid description")
            case "Bet earnings":
                transaction = AccountTransaction.betEarningTransaction(value: Value.init(amount: doubleAmount, currency: currency), date: date.text ?? "No valid date", description: descrip.text ?? "No valid description")
            case "Clothes sales":
                transaction = AccountTransaction.clothesSalesTransaction(value: Value.init(amount: doubleAmount, currency: currency), date: date.text ?? "No valid date", description: descrip.text ?? "No valid description")
            case "Flat renting":
                transaction = AccountTransaction.rentingTransaction(value: Value.init(amount: doubleAmount * (-1), currency: currency), date: date.text ?? "No valid date", description: descrip.text ?? "No valid description")
            case "Food":
                transaction = AccountTransaction.foodTransaction(value: Value.init(amount: doubleAmount * (-1), currency: currency), date: date.text ?? "No valid date", description: descrip.text ?? "No valid description")
            case "Car maintenance":
                transaction = AccountTransaction.carTransaction(value: Value.init(amount: doubleAmount * (-1), currency: currency), date: date.text ?? "No valid date", description: descrip.text ?? "No valid description")
            case "Party expenses":
                transaction = AccountTransaction.partyTransaction(value: Value.init(amount: doubleAmount * (-1), currency: currency), date: date.text ?? "No valid date", description: descrip.text ?? "No valid description")
            default:
                print("Default switch")
        }
        
        DataController.shared.insertTransaction(transaction: transaction!)
        self.dismiss(animated: true, completion: nil)
        
        self.delegate?.didTransactionAdded() // I am issuer
        
        // Closure: When clicking on newTransactionVC plus button, system must calculate
        // the result of all the transactions value and print it in the total label of mainVC
        self.updateTotal!()
        
        }
    
    }
    
}




// MARK: - CATEGORY BUTTON 1st: Button Class 2nd DropDownView Class



protocol DropDownProtocol {
    func selectCategory(category: String)
}


// Class button
class DropDownBtn: UIButton, DropDownProtocol{
    
    func selectCategory(category: String) {
        self.setTitle(category, for: .normal)
        self.dismissDropDown()
    }
    
    
    var dropView = DropDownView()
    var height = NSLayoutConstraint()
    
    var amountDis: (() -> Void)?
    var amountEna: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Inside of our frame we are gonna setup the button in terms of the drop down menu
        dropView = DropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    override func didMoveToSuperview(){
            self.superview?.addSubview(dropView)
            self.superview?.bringSubviewToFront(dropView)
            
            dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            height = dropView.heightAnchor.constraint(equalToConstant: 0)
            
        }
        
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        if isOpen == false {
            
            self.amountDis?()
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 170 {
                self.height.constant = 170
            } else {
                self.height.constant = dropView.tableView.contentSize.height
            }
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
            
  
        } else {
            
            self.amountEna?()
            
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)

        }
    
    }
    
    func dismissDropDown() {
        self.amountEna?()
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// Class for the drop down content
class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var dropDownOption = [String]()
    
    var tableView = UITableView()
    
    var delegate: DropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        tableView.backgroundColor = UIColor.darkGray
//        self.backgroundColor = UIColor.darkGray

        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectCategory(category: dropDownOption[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    // UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownOption[indexPath.row]
        cell.textLabel?.textColor = UIColor.darkGray
        return cell
        
    }
    
}




















// MARK: - CURRENCY BUTTON 1st Button Class 2nd DropDownView Class


protocol CurrencyDropDownProtocol {
    func currencyPressed(currency: String)
}

class CurrencyButton: UIButton, CurrencyDropDownProtocol {
    
    func currencyPressed(currency: String) {
        self.setTitle(currency, for: .normal)
        self.dismissCurrencyList()
    }
    
    
    var currencyDropDownView = CurrencyDropDownView()
    
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        currencyDropDownView = CurrencyDropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        currencyDropDownView.delegate = self
        
    }
    
    override func didMoveToSuperview() {
        
        
        self.superview?.addSubview(currencyDropDownView)
        self.superview?.bringSubviewToFront(currencyDropDownView)
        
        currencyDropDownView.translatesAutoresizingMaskIntoConstraints = false
        
        currencyDropDownView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        currencyDropDownView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //currencyDropDownView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        currencyDropDownView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        height = currencyDropDownView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?){
        if isOpen == false {
            
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            
            if currencyDropDownView.tableView.contentSize.height > 100 {
                self.height.constant = 100
            } else {
                self.height.constant = currencyDropDownView.tableView.contentSize.height
            }
            
            NSLayoutConstraint.activate([self.height])
            
            
        } else {
            
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            
            self.height.constant = 0
            
            NSLayoutConstraint.activate([self.height])
            
            self.currencyDropDownView.center.y -= self.currencyDropDownView.frame.height / 2

            
        }
    }
    
    func dismissCurrencyList() {
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        
        self.height.constant = 0
        
        NSLayoutConstraint.activate([self.height])
        
        self.currencyDropDownView.center.y -= self.currencyDropDownView.frame.height / 2

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





class CurrencyDropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: CurrencyDropDownProtocol!
    
    var currencyList = [String]()
    
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.currencyPressed(currency: currencyList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = currencyList[indexPath.row]
        cell.textLabel?.textColor = UIColor.darkGray
        return cell
    }
    
}










