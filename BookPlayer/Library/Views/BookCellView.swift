//
//  BookCellView.swift
//  BookPlayer
//
//  Created by Florian Pichler on 12.04.18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//

import UIKit

enum PlaybackState {
    case playing
    case paused
    case stopped
}

enum BookCellType {
    case book
    case playlist
    case file // in a playlist
}

class BookCellView: UITableViewCell {
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var progressTrailing: NSLayoutConstraint!
    @IBOutlet private weak var progressView: ItemProgress!
    @IBOutlet private weak var artworkButton: UIButton!

    var onArtworkTap: (() -> Void)?

    var artwork: UIImage? {
        get {
            return self.artworkImageView.image
        }
        set {
            self.artworkImageView.layer.cornerRadius = 4.0
            self.artworkImageView.layer.masksToBounds = true

            self.artworkImageView.image = newValue
        }
    }

    var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }

    var subtitle: String? {
        get {
            return self.subtitleLabel.text
        }
        set {
            self.subtitleLabel.text = newValue
        }
    }

    var progress: Double {
        get {
            return self.progressView.value
        }
        set {
            self.progressView.value = newValue
        }
    }

    var type: BookCellType = .book {
        didSet {
            switch self.type {
                case .file:
                    self.accessoryType = .none

                    self.progressTrailing.constant = 11.0
                case .playlist:
                    self.accessoryType = .disclosureIndicator

                    self.progressTrailing.constant = -5.0
                default:
                    self.accessoryType = .none

                    self.progressTrailing.constant = 29.0 // Disclosure indicator offset
            }
        }
    }

    var playbackState: PlaybackState = PlaybackState.stopped {
        didSet {
            switch self.playbackState {
                case .playing:
                    self.artworkButton.backgroundColor = UIColor.tintColor.withAlpha(newAlpha: 0.3)
                    self.titleLabel.textColor = UIColor.tintColor
                    self.progressView.pieColor = UIColor.tintColor
                case .paused:
                    self.artworkButton.backgroundColor = UIColor.tintColor.withAlpha(newAlpha: 0.3)
                    self.titleLabel.textColor = UIColor.tintColor
                    self.progressView.pieColor = UIColor.tintColor
                default:
                    self.artworkButton.backgroundColor = UIColor.clear
                    self.titleLabel.textColor = UIColor.textColor
                    self.progressView.pieColor = UIColor(hex: "8F8E94")
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    private func setup() {
        self.accessoryType = .none
        self.selectionStyle = .none
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        self.artworkImageView.layer.cornerRadius = 3.0
        self.artworkImageView.layer.masksToBounds = true

        self.artworkButton.layer.cornerRadius = 3.0
        self.artworkButton.layer.masksToBounds = true
    }

    @IBAction func artworkButtonTapped(_ sender: Any) {
        self.onArtworkTap?()
    }
}
