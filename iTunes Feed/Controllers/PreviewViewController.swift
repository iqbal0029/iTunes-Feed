//
//  MasterViewController.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/24/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import UIKit

final class PreviewViewController: UITableViewController {
    
    @IBOutlet weak var contentDescriptionLabel: UILabel!

    var endPoint: URL!
    private var endPointCopy: URL! //this is to check whether URL changed in setting
    var feed: Feed! { //this is the feed, fetches by URLSession
        didSet {
            DispatchQueue.main.async {
                self.setAlbumDescriptionLabel()
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialOneTimeSetup()
    }

    func initialOneTimeSetup() {
        addSettingBarButton()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = RSSFeed.default.mediaType.rawValue
        endPoint = RSSFeed.default.endPoint
        //this loop is to check whether something changed in settings
        if endPointCopy != nil && endPointCopy == endPoint { return }
        fetchContents()
    }

    func fetchContents() {
        SHUD.show(text: "Fetching...")
        Service.fetchContentsFrom(url: endPoint) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.feed = result
                SHUD.hide(success: true, text: "Done")
            case .failure(let error):
                self.feed = nil
                SHUD.hide()
                self.showAlert(message: error.description)
            }
        }
    }
}

// MARK: - Navigation & Segues
extension PreviewViewController {
    @objc func showSettingViewController(_ sender: Any) {
        let settingSegueIdentifier = R.Segue.showSetting.rawValue
        performSegue(withIdentifier: settingSegueIdentifier, sender: nil)
    }

    func showDetailViewController() {
        let detailVCSegueIdentifier = R.Segue.showDetail.rawValue
        performSegue(withIdentifier: detailVCSegueIdentifier, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        endPointCopy = endPoint
        if segue.identifier == R.Segue.showDetail.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let content = feed.results[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = content
            }
        }
    }
}

// MARK: - Table View
extension PreviewViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return feed != nil ? 1 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.TableCell.preview.rawValue, for: indexPath) as? PreviewTableViewCell else {
            return UITableViewCell()
        }
        let cellContent = feed.results[indexPath.row]
        let cellData = PreviewTableViewModel(imageURL: cellContent.artworkUrl100,
                              name: cellContent.name,
                              artistName: cellContent.artistName,
                              releaseDate: cellContent.releaseDate,
                              copyright: cellContent.copyright)
        cell.update(with: cellData)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailViewController()
    }
}

// MARK: - Helper Methods
extension PreviewViewController {
    func setAlbumDescriptionLabel() {
        var description = ""
        if let feed = feed {
            let updated = feed.updated.first(splitBy: "T") ?? feed.updated
            description = "\(feed.title): \(feed.results.count) results\nUpdated on: \(updated)"
        } else {
            let setting = RSSFeed.default
            description = "\(setting.selectedFeedType): 0 result"
        }
        self.contentDescriptionLabel.text = description

    }

    func addSettingBarButton() {
        let settingsButton = UIBarButtonItem(title: "⚙︎", style: .plain, target: self, action: #selector(showSettingViewController(_:)))
        let font = UIFont.systemFont(ofSize: 28)
        let attributes = [NSAttributedString.Key.font: font]
        settingsButton.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.rightBarButtonItem = settingsButton
    }

    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
