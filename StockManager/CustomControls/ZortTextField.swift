//
//  ZortTextField.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 23/5/2565 BE.
//

import UIKit
import RxSwift
import RxCocoa

public enum ZortTextFieldMode: Int {
    case textfield
    case formTextfield
    case searchbar
}

public enum ZortTextFieldValidateState: Int {
    case none
    case passed
    case failed
}

public final class ZortTextField: UITextField {

    private let bag = DisposeBag()

    public var mode: ZortTextFieldMode = .textfield {
        didSet {
            updateView()
        }
    }

    private var valueBeforeEdit: String? = nil
    private var normalBackgroundColor: UIColor = .clear
    private var disabledBackgroundColor: UIColor = .clear
    private var normalTextColor: UIColor = .zortTextfieldText
    private var unitTextColor: UIColor = .zortTextfieldText
    private var typingTextColor: UIColor = .zortTextfieldText
    private var errorTextColor: UIColor = .zortTextfieldText
    private var placeholderTextColor: UIColor = .zortTextfieldHint
    private var borderColor: UIColor = .clear
    private var editingBorderColor: UIColor = .clear
    private var errorBorderColor: UIColor = .clear

    public var isDisplayErrorEnable = true
    public var shouldValidateEmptyField = false
    public var showClearButton = true
    public var appFont = UIFont.boldSukhumvitTadmai(ofSize: 14)
    public var placeholderFont = UIFont.sukhumvitTadmai(ofSize: 14)
    public var valueChanged = PublishSubject<Bool>()
    public var clearButtonTap = PublishSubject<Void>()
    public var validateState = BehaviorSubject<ZortTextFieldValidateState>(value: .none)
    private var currentState: ZortTextFieldValidateState {
        do { return try validateState.value() }
        catch { return .none }
    }
    public var validation: ((String?) -> Bool)? = nil

    public var customFont: UIFont? {
        didSet {
            updateView()
        }
    }

    public var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    public var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }

    public var leftButton: UIButton? {
        didSet {
            updateView()
        }
    }

    public var rightButton: UIButton? {
        didSet {
            updateView()
        }
    }

    private var unitWidth: CGFloat = 0
    public var unit: String? {
        didSet {
            let label = UILabel()
            label.font = appFont
            label.text = unit
            let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                 height: CGFloat.greatestFiniteMagnitude))
            unitWidth = size.width
            updateView()
        }
    }

    public override var isEnabled: Bool {
        didSet {
            updateView()
        }
    }

    public override var placeholder: String? {
        didSet {
            updateView()
        }
    }

    public var leftPadding: CGFloat = 15
    public var rightPadding: CGFloat = 15

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        borderStyle = .none
        layer.borderWidth = 1
        clipsToBounds = true
        clearButtonMode = .never

        rx.controlEvent(.editingDidBegin).subscribe { [weak self] (_) in
            guard let strong = self else { return }
            strong.valueBeforeEdit = strong.text
            strong.validateState.onNext(.none)
            strong.layer.borderColor = strong.editingBorderColor.cgColor
            strong.textColor = strong.typingTextColor
        }.disposed(by: bag)

        rx.controlEvent(.editingDidEnd).subscribe { [weak self] (_) in
            guard let strong = self else { return }
            if strong.valueBeforeEdit != strong.text {
                strong.valueChanged.onNext(true)
            }
            strong.valueBeforeEdit = strong.text
            strong.layer.borderColor = strong.borderColor.cgColor
            strong.textColor = strong.normalTextColor
            strong.validateData()
        }.disposed(by: bag)

        updateView()
    }

    public func validateData() {
        guard validation != nil, (!(text?.isEmpty ?? true) || shouldValidateEmptyField) else { return }

        if (validation?(text) ?? false) {
            validateState.onNext(.passed)
            layer.borderColor = borderColor.cgColor
            textColor = normalTextColor
        } else {
            validateState.onNext(.failed)
            if isDisplayErrorEnable {
                layer.borderColor = errorBorderColor.cgColor
                textColor = errorTextColor
            }
        }
    }

    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 19
        leftViewRect.size.width = 20
        return leftViewRect
    }

    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= rightPadding
        let width: CGFloat
        if rightImage != nil && unitWidth > 0 {
            width = 34 + unitWidth
        } else if rightImage != nil || rightButton != nil {
            width = 24
        } else {
            width = unitWidth
        }
        rightViewRect.size.width = width
        return rightViewRect
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        textRect.size.width -= (leftPadding + rightPadding)
        return textRect
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var editingRect = super.editingRect(forBounds: bounds)
        editingRect.origin.x += leftPadding
        editingRect.size.width -= (leftPadding + rightPadding)
        return editingRect
    }

    public func clearData() {
        self.text = nil
    }

    private func updateView() {

        switch mode {
        case .textfield:
            heightAnchor.constraint(equalToConstant: 50).isActive = true
            layer.cornerRadius = 25
            normalBackgroundColor = .white
            disabledBackgroundColor = .lightGray
            self.borderColor = .clear
            self.tintColor = .zortTextfieldText
            self.normalTextColor = .zortTextfieldText
            self.unitTextColor = .zortTextfieldText
            self.typingTextColor = .zortTextfieldText
            self.errorTextColor = .zortTextfieldText
            self.errorBorderColor = .red
            self.editingBorderColor = .clear
            self.layer.borderColor = self.borderColor.cgColor
            self.font = customFont ?? appFont
            textColor = self.normalTextColor
            self.placeholderTextColor = .zortTextfieldHint
            self.placeholderFont = .sukhumvitTadmai(ofSize: 14)

        case .formTextfield:
            heightAnchor.constraint(equalToConstant: 40).isActive = true
            layer.cornerRadius = 10
            normalBackgroundColor = .gray200
            disabledBackgroundColor = .darkGray
            self.borderColor = .clear
            self.tintColor = .zortTextfieldText
            self.normalTextColor = .zortTextfieldText
            self.unitTextColor = .zortTextfieldText
            self.typingTextColor = .zortTextfieldText
            self.errorTextColor = .zortTextfieldText
            self.errorBorderColor = .red
            self.editingBorderColor = .clear
            self.layer.borderColor = self.borderColor.cgColor
            self.font = customFont ?? appFont
            textColor = self.normalTextColor
            self.placeholderTextColor = .gray500
            self.placeholderFont = .sukhumvitTadmai(ofSize: 14)

        case .searchbar:
            heightAnchor.constraint(equalToConstant: 40).isActive = true
            layer.cornerRadius = 20
            normalBackgroundColor = .white
            disabledBackgroundColor = .lightGray
            self.borderColor = UIColor(hexString: "#EAEAEA")
            self.tintColor = .zortTextfieldText
            self.normalTextColor = .zortTextfieldText
            self.unitTextColor = .zortTextfieldText
            self.typingTextColor = .zortTextfieldText
            self.errorTextColor = .zortTextfieldText
            self.errorBorderColor = .clear
            self.editingBorderColor = UIColor(hexString: "#EAEAEA")
            self.layer.borderColor = self.borderColor.cgColor
            self.font = customFont ?? appFont
            textColor = self.normalTextColor
            self.placeholderTextColor = .zortTextfieldHint
            self.placeholderFont = .sukhumvitTadmai(ofSize: 14)
        }

        backgroundColor = isEnabled ? normalBackgroundColor : disabledBackgroundColor

        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            leftView = imageView
        } else if let button = leftButton {
            leftViewMode = UITextField.ViewMode.always
            leftView = button
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }

        if let image = rightImage, let unit = self.unit, !unit.isEmpty {
            rightViewMode = UITextField.ViewMode.always
            let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 34 + unitWidth, height: 24))
            stackView.backgroundColor = .clear
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 10
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: unitWidth, height: 24))
            label.font = appFont
            label.textColor = unitTextColor
            label.text = unit
            stackView.addArrangedSubview(label)
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            stackView.addArrangedSubview(imageView)
            rightView = stackView
        } else if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            rightView = imageView
        } else if let unit = self.unit {
            rightViewMode = UITextField.ViewMode.always
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: unitWidth, height: 24))
            label.font = appFont
            label.textColor = unitTextColor
            label.text = unit
            rightView = label
        } else if let button = rightButton {
            rightViewMode = UITextField.ViewMode.always
            rightView = button
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }

        attributedPlaceholder = NSAttributedString(
            string: placeholder != nil ?  placeholder! : "",
            attributes: [
                NSAttributedString.Key.font: placeholderFont,
                NSAttributedString.Key.foregroundColor: placeholderTextColor
            ]
        )
    }
}
