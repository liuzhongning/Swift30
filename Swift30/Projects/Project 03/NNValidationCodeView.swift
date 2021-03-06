//
//  NNValidationCodeView.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/16.
//  Copyright © 2020 刘朋坤. All rights reserved.
//

import UIKit

class NNValidationCodeView: UIView, UITextFieldDelegate {
    let codeTextField = NNTextField()
    // 验证码数量，默认 6 个
    var labelCount = NSInteger()
    // 验证码距离，默认 5
    var labelDistance = CGFloat()
    // 输入后的颜色，默认红色
    var changedColor = UIColor()
    // 输入前的颜色，默认黑色
    var defaultColor = UIColor()
    // 存放 label 的数组
    private var labelArr = NSMutableArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        labelCount = 6
        labelDistance = 5
        changedColor = UIColor.red
        defaultColor = UIColor.black
        
        setupUI()
    }
    
    // MARK: - 监听文本输入 核心操作
    @objc func textFieldDidChange(_ textField: UITextField) {
        let i = textField.text?.count
        if i! > labelCount {
            return
        }
        if i == 0 {
            ((labelArr.object(at: 0)) as! UILabel).text = ""
            ((labelArr.object(at: 0)) as! UILabel).layer.borderColor = defaultColor.cgColor
        } else {
            ((labelArr.object(at: (i! - 1))) as! UILabel).text = (textField.text! as NSString).substring(with: NSMakeRange(i! - 1, 1))
            ((labelArr.object(at: (i! - 1))) as! UILabel).layer.borderColor = changedColor.cgColor
            ((labelArr.object(at: (i! - 1))) as! UILabel).textColor = changedColor
            if labelCount > i! {
                ((labelArr.object(at: (i!))) as! UILabel).text = ""
                ((labelArr.object(at: (i!))) as! UILabel).layer.borderColor = defaultColor.cgColor
            }
        }
    }
    
    // MARK: - setupUI
    func setupUI() {
        setupTextField()
        var labelX = CGFloat()
        let labelY : CGFloat = 0.0
        let labelWidth = self.bounds.size.width / CGFloat(labelCount)
        let sideLength = labelWidth < self.bounds.size.height ? labelWidth : self.bounds.size.height
        
        for i in 0..<labelCount {
            if i == 0 {
                labelX = 0
            } else {
                labelX = CGFloat(i) * (sideLength + labelDistance)
            }
            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: sideLength, height: sideLength))
            self.addSubview(label)
            label.textAlignment = NSTextAlignment.center
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1.0
            label.layer.cornerRadius = sideLength / 2.0
            labelArr.add(label)
        }
    }
    
    // MARK: - 设置输入框
    func setupTextField() {
        codeTextField.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        codeTextField.backgroundColor = UIColor.clear
        codeTextField.textColor = UIColor.clear
        codeTextField.tintColor = UIColor.clear
        codeTextField.delegate = self
        codeTextField.autocapitalizationType = UITextAutocapitalizationType.none
        codeTextField.keyboardType = UIKeyboardType.numberPad
        codeTextField.layer.borderColor = UIColor.gray.cgColor
        codeTextField.isUserInteractionEnabled = true
        codeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.addSubview(codeTextField)
    }
    
    // MARK: - UITextFieldDelegate
    // MARK: 监听输入框
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 允许删除
        if (string.count == 0) {
            return true
        } else if (textField.text?.count)! >= labelCount {
            return false
        } else {
            return true
        }
    }
    // MARK: 回车收起键盘
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 重写 UITextFiled , 解决长按复制粘贴的问题
class NNTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
