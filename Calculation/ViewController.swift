//
//  ViewController.swift
//  Calculation
//
//  Created by 김태현 on 2020/05/10.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Equation{
        case devision
        case substract
        case add
        case multi
    }
    
    var m_clearFlag : Bool = true;
    var m_dotFlag : Bool = false;
    var m_lastEquation : Equation = .add;
    
    var m_result : Double = 0;
    var m_firstValue : Double = 0;
    var m_secondValue : Double = 0;
    
    @IBOutlet var buttonCollection : [UIButton]!
    @IBOutlet weak var inputNumber: UITextField!
    
    @inline(__always) func SetFlag( clearFlag : Bool , dotFlag : Bool)
    {
        m_clearFlag = clearFlag;
        m_dotFlag = dotFlag;
    }
    func GetDouble (from textField : UITextField)->double_t
    {
        guard let text = textField.text , let number = double_t(text) else
        {
            return 0 ;
        }
        return number;
    }
    
    func GetReverse (from textField : UITextField)->double_t
    {
        var number : double_t = GetDouble(from: textField);
        number *= -1;
        return number;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        for index in 0..<buttonCollection.count
        {
            buttonCollection[index].layer.borderColor = UIColor.darkGray.cgColor;
            buttonCollection[index].layer.borderWidth = 1;
            buttonCollection[index].layer.cornerRadius = 10;
        }
    }
    
    @IBAction func NumberButtonManager(_ sender : NumberButton)
    {
        if( true == m_clearFlag )
        {
            inputNumber.text = "";
            m_clearFlag = false;
        }
        inputNumber.text?.append(String(sender.number))
    }
    
    @IBAction func bnAC(_ sender: Any) {
        inputNumber.text = "";
        SetFlag(clearFlag : false ,dotFlag:  false);
    }
    
    @IBAction func bnReverse(_ sender: Any) {
        inputNumber.text = String(GetReverse(from: inputNumber));
       SetFlag(clearFlag : true ,dotFlag:  false);
    }
    
    @IBAction func bnPercentage(_ sender: Any) {
        var number : double_t = GetDouble(from:inputNumber);
        number /= 100;
        inputNumber.text = String(number);
    }
    
    @IBAction func bnDivision(_ sender: Any) {
        m_firstValue = GetDouble(from:inputNumber);
        m_lastEquation = .devision;
        SetFlag(clearFlag : true ,dotFlag:  false);
    }
    
    @IBAction func bnMulti(_ sender: Any) {
        m_firstValue = GetDouble(from:inputNumber);
        m_lastEquation = .multi;
        SetFlag(clearFlag : true ,dotFlag:  false);
    }
    
    @IBAction func bnSubstract(_ sender: Any) {
        m_firstValue = GetDouble(from:inputNumber);
        m_lastEquation = .substract;
        SetFlag(clearFlag : true ,dotFlag:  false);
    }
    
    @IBAction func bnAdd(_ sender: Any) {
        m_firstValue = GetDouble(from:inputNumber);
        m_lastEquation = .add;
        SetFlag(clearFlag : true ,dotFlag:  false);
    }
    
    @IBAction func bnResult(_ sender: Any) {
        m_secondValue = GetDouble(from:inputNumber);
        switch m_lastEquation
        {
        case .add:
            m_result = m_firstValue + m_secondValue;
            break;
        case .substract :
            m_result = m_firstValue - m_secondValue;
            break;
        case .multi:
            m_result = m_firstValue * m_secondValue;
            break;
        case .devision:
            m_result = m_firstValue / m_secondValue;
            break;
        }
        inputNumber.text = String(m_result);
       SetFlag(clearFlag : true ,dotFlag:  false);
    }
    
    @IBAction func bnDot(_ sender: Any) {
        if( false == m_dotFlag )
        {
            m_dotFlag = true;
            inputNumber.text?.append(".");
        }
    }
    
}

