import UIKit
import SnapKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var audioPlayer: AVAudioPlayer?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 120)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var cards: [Card] = []

    var flippedCardIndices: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioPlayer()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        collectionView.delegate = self
        collectionView.dataSource = self


        cards = [
            Card(word: "Apple"),
            Card(word: "Banana"),
            Card(word: "Cherry"),
            Card(word: "Apple"),
            Card(word: "Banana"),
            Card(word: "Cherry"),
            Card(word: "Apple"),
            Card(word: "Banana"),
            Card(word: "Cherry"),
            Card(word: "Apple"),
            Card(word: "Banana"),
            Card(word: "Cherry"),
            Card(word: "Apple"),
            Card(word: "Banana"),
            Card(word: "Cherry"),
            Card(word: "Apple"),
            Card(word: "Banana"),
            Card(word: "Cherry")
            
        ].shuffled()

        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.item]

        if card.isFlipped {
            cell.button.setTitle(card.word, for: .normal)
            cell.button.backgroundColor = .white
        } else {
            cell.button.setTitle("", for: .normal)  // Ensure that the title is set to an empty string
            cell.button.backgroundColor = .blue
        }

        cell.button.addTarget(self, action: #selector(cardButtonTapped(_:)), for: .touchUpInside)
        cell.button.tag = indexPath.item

        return cell
    }


    @objc func cardButtonTapped(_ sender: UIButton) {
        let index = sender.tag

        // Check if the card is already flipped or matched
        guard !cards[index].isFlipped, flippedCardIndices.count < 2 else {
            return
        }

        cards[index].isFlipped = true
        flippedCardIndices.append(index)

        collectionView.reloadData()

        // Check if two cards are flipped
        if flippedCardIndices.count == 2 {
            let firstCard = cards[flippedCardIndices[0]]
            let secondCard = cards[flippedCardIndices[1]]

            if firstCard.word == secondCard.word {
                // Matched, hide the cards
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                  //  self.hideMatchedCards()
                    self.cards[0].isFlipped = false
                    self.cards[1].isFlipped = false
                    self.flippedCardIndices.removeAll()
                    self.audioPlayer?.play()
                    self.collectionView.reloadData()
                }
            } else {
                // Not matched, flip back the cards
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.flipBackCards()
                }
            }
        }
    }

    func hideMatchedCards() {
//        for index in flippedCardIndices {
//            cards[index].isFlipped = true
//
//        }
//        
//        flippedCardIndices.removeAll()
//        audioPlayer?.play()
//        collectionView.reloadData()
        
       
    }


    func flipBackCards() {
        for index in flippedCardIndices {
            cards[index].isFlipped = false
        }
        flippedCardIndices.removeAll()
        audioPlayer?.play()
        collectionView.reloadData()
    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
    
           return CGSize(width: 90, height: 90)
       }
    
    
    func setupAudioPlayer() {
        if let soundFilePath = Bundle.main.path(forResource: "cardflip", ofType: "wav") {
            let soundFileURL = URL(fileURLWithPath: soundFilePath)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error initializing audio player: \(error.localizedDescription)")
            }
        }
    }
}

