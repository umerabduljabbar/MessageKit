/*
 MIT License

 Copyright (c) 2017-2018 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation
import CoreLocation
import MessageKit

private struct MyLocationItem: LocationItem {

    var location: CLLocation
    var size: CGSize

    init(location: CLLocation) {
        self.location = location
        self.size = CGSize(width: 240, height: 240)
    }

}

private struct MyMediaItem: MediaItem {

    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize

    init(image: UIImage) {
        self.image = image
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage()
    }
    
    init(url: URL) {
        self.url = url
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = #imageLiteral(resourceName: "icons8-music")
    }

}

internal struct MyMessage: MessageType {

    var messageId: String
    var sender: Sender
    var sentDate: Date
    var kind: MessageKind
    var status: Status

    private init(kind: MessageKind, sender: Sender, messageId: String, date: Date, status: Status) {
        self.kind = kind
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
        self.status = status
    }

    init(text: String, sender: Sender, messageId: String, date: Date, status: Status) {
        self.init(kind: .text(text), sender: sender, messageId: messageId, date: date, status: status)
    }

    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date, status: Status) {
        self.init(kind: .attributedText(attributedText), sender: sender, messageId: messageId, date: date, status: status)
    }

    init(image: UIImage, sender: Sender, messageId: String, date: Date, status: Status) {
        let mediaItem = MyMediaItem(image: image)
        self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, date: date, status: status)
    }

    init(thumbnail: UIImage, sender: Sender, messageId: String, date: Date, status: Status) {
        let mediaItem = MyMediaItem(image: thumbnail)
        self.init(kind: .video(mediaItem), sender: sender, messageId: messageId, date: date, status: status)
    }
    
    init(imageUrl: URL, sender: Sender, messageId: String, date: Date, status: Status) {
        let mediaItem = MyMediaItem(url: imageUrl)
        self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, date: date, status: status)
    }
    
    init(imageUrl: String, sender: Sender, messageId: String, date: Date, status: Status) {
        let url = URL(string: imageUrl)
        let mediaItem = MyMediaItem(url: url!)
        self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, date: date, status: status)
    }
    
    init(url: URL, sender: Sender, messageId: String, date: Date, status: Status) {
        let mediaItem = MyMediaItem(url: url)
        self.init(kind: .audio(mediaItem), sender: sender, messageId: messageId, date: date, status: status)
    }

    init(location: CLLocation, sender: Sender, messageId: String, date: Date, status: Status) {
        let locationItem = MyLocationItem(location: location)
        self.init(kind: .location(locationItem), sender: sender, messageId: messageId, date: date, status: status)
    }

    init(emoji: String, sender: Sender, messageId: String, date: Date, status: Status) {
        self.init(kind: .emoji(emoji), sender: sender, messageId: messageId, date: date, status: status)
    }

}
