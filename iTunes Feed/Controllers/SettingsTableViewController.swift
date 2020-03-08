//
//  SettingsTableViewController.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/25/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import UIKit

enum FeedSettingsType {
    case country
    case mediaType
    case feedType
    case resultLimit
}

final class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var mediaTypeButton: UIButton!
    @IBOutlet weak var feedTypeButton: UIButton!
    @IBOutlet weak var resultLimitButton: UIButton!
    @IBOutlet weak var allowExplicitSwitch: UISwitch!
    
        
    let feedSettings = RSSFeed.default
    var pickerData = [String]()
    let picker = UIPickerView()
    var currentSettingType: FeedSettingsType!
    
    var isDoneBarButtonEnabled: Bool {
        get {
            return navigationItem.rightBarButtonItem?.isEnabled ?? false
        } set {
            navigationItem.rightBarButtonItem?.isEnabled = newValue
            if newValue == true {
                showPickerView()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        RSSFeed.archiveRSSFeed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialOneTimeSetup()
    }
    
    @IBAction func countryButtonPressed(_ sender: UIButton) {
        pickerData = feedSettings.supportedCountry
        view.addSubview(picker)
        isDoneBarButtonEnabled = true
        currentSettingType = .country
        showSelectedValueInPicker(sender)
    }
    
    @IBAction func mediaTypeButtonPressed(_ sender: UIButton) {
        pickerData = feedSettings.supportedMediaType
        view.addSubview(picker)
        isDoneBarButtonEnabled = true
        currentSettingType = .mediaType
        showSelectedValueInPicker(sender)
    }
    
    @IBAction func feedTypeButtonPressed(_ sender: UIButton) {
        pickerData = feedSettings.mediaType.allFeedType
        view.addSubview(picker)
        isDoneBarButtonEnabled = true
        currentSettingType = .feedType
        showSelectedValueInPicker(sender)
    }
    
    @IBAction func resultlimitButtonPressed(_ sender: UIButton) {
        pickerData = feedSettings.supportedResultLimit
        view.addSubview(picker)
        isDoneBarButtonEnabled = true
        currentSettingType = .resultLimit
        showSelectedValueInPicker(sender)
    }
    
    @IBAction func allowExplicitButtonPressed(_ sender: UISwitch) {
        feedSettings.isAllowedExplicit = sender.isOn
    }
    
    @objc func doneButtonPressed() {
        picker.removeFromSuperview()
        isDoneBarButtonEnabled = false
        let selectedRow = picker.selectedRow(inComponent: 0)
        switch currentSettingType! {
        case .country:
            feedSettings.country = pickerData[selectedRow]
        case .mediaType:
            feedSettings.mediaType = MediaType(rawValue: pickerData[selectedRow]) ?? .apple_music
        case .feedType:
            feedSettings.selectedFeedType = pickerData[selectedRow]
        case .resultLimit:
            feedSettings.resultLimit = pickerData[selectedRow]
        }
        updateSettingsUI()
    }

    @objc func tapOnView() {
        if isDoneBarButtonEnabled == true {
            doneButtonPressed()
        }
    }
    
}

//MARK: PickerView
extension SettingsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func showPickerView() {
        picker.reloadAllComponents()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func showSelectedValueInPicker(_ sender: UIButton) {
        let selectedIndex = pickerData.firstIndex(of: sender.currentTitle!) ?? 0
        picker.selectRow(selectedIndex, inComponent: 0, animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        if UIDevice.current.userInterfaceIdiom == .pad {
            pickerLabel.font = UIFont.systemFont(ofSize: 25)
        } else if UIDevice.current.userInterfaceIdiom == .phone {
            pickerLabel.font = UIFont.systemFont(ofSize: 20)
        }
        pickerLabel.textAlignment = .center
        pickerLabel.text = pickerData[row]
        return pickerLabel
    }
}

//MARK: Helper Method
extension SettingsTableViewController {
    func initialOneTimeSetup() {
        updateSettingsUI()

        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        isDoneBarButtonEnabled = false

        picker.dataSource = self
        picker.delegate = self

        let tapGestureOnView = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        view.addGestureRecognizer(tapGestureOnView)
    }

    func updateSettingsUI() {
        countryButton.setTitle(feedSettings.country, for: .normal)
        mediaTypeButton.setTitle(feedSettings.mediaType.rawValue, for: .normal)
        feedTypeButton.setTitle(feedSettings.selectedFeedType, for: .normal)
        resultLimitButton.setTitle("\(feedSettings.resultLimit)", for: .normal)
        allowExplicitSwitch.setOn(feedSettings.isAllowedExplicit, animated: true)
    }
}
