//
//  ViewController.swift
//  Localized App
//
//  Created by Sotheavuth Nguon on 1/26/20.
//  Copyright © 2020 Sotheavuth Nguon. All rights reserved.
//

import UIKit
import Localize_Swift

class ViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var changeButton: UIButton!
  @IBOutlet weak var resetButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setText()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      NotificationCenter.default.removeObserver(self)
  }
  
  @objc func setText() {
    label.text = "Hello world".localized()
    changeButton.setTitle("Change".localized(using: "ButtonTitles"), for: .normal)
    resetButton.setTitle("Reset".localized(using: "ButtonTitles"), for: .normal)
  }

  @IBAction func changeLanguageButtonPressed(_ sender: UIButton) {
    
    let availableLanguages = Localize.availableLanguages().filter { $0 != "Base" }
    let actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertController.Style.actionSheet)
    for language in availableLanguages {
        let displayName = Localize.displayNameForLanguage(language)
        let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
                Localize.setCurrentLanguage(language)
        })
        actionSheet.addAction(languageAction)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
        (alert: UIAlertAction) -> Void in
    })
    actionSheet.addAction(cancelAction)
    present(actionSheet, animated: true, completion: nil)
  }
  
  @IBAction func resetButtonPressed(_ sender: UIButton) {
    Localize.resetCurrentLanguageToDefault()
  }
  
  
}

