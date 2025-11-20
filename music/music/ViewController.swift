import UIKit

import AVFAudio

struct Track {
    let title: String
    let artist: String
    let coverImageName: String
    let audioFileName: String
}

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    
    private var tracks: [Track] = [
        Track(title: "in the pool",   artist: "крутойчел", coverImageName: "cover1", audioFileName: "track1"),
        Track(title: "what u wishin for?",   artist: "крутойчел", coverImageName: "cover2", audioFileName: "track2"),
        Track(title: "вайбик", artist: "крутойчел", coverImageName: "cover3", audioFileName: "track3"),
        Track(title: "where time go?",  artist: "lil peep", coverImageName: "cover4", audioFileName: "track4"),
        Track(title: "domension",  artist: "айдос", coverImageName: "cover5", audioFileName: "track5")
    ]
    private var currentIndex: Int = 0
    private var player: AVAudioPlayer?
    private var progressTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        loadTrack(at: currentIndex, autoPlay: false)
    }
    
    private func configureButtons() {
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        view.backgroundColor = .black
        trackTitleLabel.textColor = .label
        artistLabel?.textColor = .secondaryLabel
    }
    
    private func updatePlayPauseIcon(isPlaying: Bool) {
        let symbol = isPlaying ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: symbol), for: .normal)
    }
    
    private func loadTrack(at index: Int, autoPlay: Bool) {
        guard index >= 0, index < tracks.count else { return }
        let track = tracks[index]

        trackTitleLabel.text = track.title
        artistLabel?.text = track.artist
        coverImageView.image = UIImage(named: track.coverImageName)

        stopPlayback()

        let url = Bundle.main.url(forResource: track.audioFileName, withExtension: "mp3")
        ?? Bundle.main.url(forResource: track.audioFileName, withExtension: "m4a")

        guard let url else {
            print("Audio file not found: \(track.audioFileName)")
            updatePlayPauseIcon(isPlaying: false)
            return
        }
        
        do {
            let p = try AVAudioPlayer(contentsOf: url)
            p.delegate = self
            p.prepareToPlay()
            player = p

            if autoPlay {
                p.play()
                    updatePlayPauseIcon(isPlaying: true)
            } else {
                    updatePlayPauseIcon(isPlaying: false)
                }
        } catch {
                print("Audio error: \(error)")
                updatePlayPauseIcon(isPlaying: false)
        }
    }
    
    private func stopPlayback() {
        progressTimer?.invalidate()
        progressTimer = nil
        player?.stop()
        player = nil
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = player else {
                loadTrack(at: currentIndex, autoPlay: true)
                return
        }
        if player.isPlaying {
                 player.pause()
                 updatePlayPauseIcon(isPlaying: false)
        } else {
                 player.play()
                 updatePlayPauseIcon(isPlaying: true)
        }
    }
    
    @IBAction private func prevTapped(_ sender: UIButton) {
        currentIndex = (currentIndex - 1 + tracks.count) % tracks.count
        loadTrack(at: currentIndex, autoPlay: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        currentIndex = (currentIndex + 1) % tracks.count
        loadTrack(at: currentIndex, autoPlay: true)
    }
}

