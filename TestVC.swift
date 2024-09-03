//
//  TestVC.swift
//  ToDoList
//
//  Created by Sergei Runov on 02.09.2024.
//

import UIKit

class TestVC: UIViewController {
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.text = "A text view that has scrolling enabled doesn’t have an intrinsic content size. You must constrain the width and height. The text view shows the text in the available space scrolling if needed. With scrolling disabled a text view acts as a UILabel with numberOfLines set to zero. Unless you constrain the width a text view has the intrinsic content size for a single line of text (assuming no carriage returns). Once you constrain the width, the text view sets its intrinsic content size height for the number of lines needed to show the text at that width."
        textView.backgroundColor = .yellow
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let textView2: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.text = "Short textView"
        textView.backgroundColor = .yellow
        textView.font = .preferredFont(forTextStyle: .caption1)
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .firstBaseline
        stack.backgroundColor = .cyan
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.backgroundColor = .systemPink
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.arrow.up.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let icon2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(hStack)
        [icon, vStack, icon2].forEach { hStack.addArrangedSubview($0) }
        vStack.addArrangedSubview(textView)
        vStack.addArrangedSubview(textView2)

        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            hStack.topAnchor.constraint(equalTo: margins.topAnchor),
            hStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            textView.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),

            textView2.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            textView2.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),

            icon.widthAnchor.constraint(equalToConstant: 24),

            icon2.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

#Preview {
    return TestVC()
}
