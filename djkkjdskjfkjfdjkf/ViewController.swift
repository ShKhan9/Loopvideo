import Foundation
import UIKit
import AVKit
import AVFoundation

class RampWallPush: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load video resource
        if let videoUrl = Bundle.main.url(forResource: "sample", withExtension: "mp4") {
            
            // Init video
            self.player = AVPlayer(url: videoUrl)
            self.player?.isMuted = true
            self.player?.actionAtItemEnd = .none
            
            // Add player layer
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            playerLayer.frame = view.frame
            
            // Add video layer
            self.videoView.layer.addSublayer(playerLayer)
            
            // Play video
            self.player?.play()
            
            // Observe end
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        }
        else {
            
            print("NoFile")
        }
    }
    
    // MARK: - Loop video when ended.
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        self.player?.seek(to: CMTime.zero)
        self.player?.play()
    }
    
}
