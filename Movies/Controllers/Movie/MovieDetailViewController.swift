//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/1/20.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var titleOriginalLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    let dataService = MovieDataService()
    var actors = [Cast]()

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        if let data = movie {
            let url = URL(string: "https://image.tmdb.org/t/p/original\(data.backdropPath)")!
            imgImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "default-placeholder"))
            titleOriginalLabel.text = "📺 \(data.originalTitle)"
            voteAverageLabel.text = "\(data.voteAverage) ⭐️"
            voteCountLabel.text = "\(data.voteCount) 📤"
            releaseDateLabel.text = "\(data.releaseDate) 🗓"
            overviewLabel.text = data.overview
            
            getActorList(id: data.id )
        }
        
    }
    
    func setupUI() {
        configreNavigationBar()
        configureCollectionView()
    }
    
    func configreNavigationBar() {
        
        navigationItem.title = movie!.title
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9215686275, green: 0.6352941176, blue: 0.262745098, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9215686275, green: 0.6352941176, blue: 0.262745098, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9215686275, green: 0.6352941176, blue: 0.262745098, alpha: 1)]
    }
    
    func configureCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        castCollectionView.collectionViewLayout = layout
    }
    
    
    func getActorList(id: Int) {
        
        dataService.fetchActor(movie: id, completion: { (data, error) in
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if let `data` = data {
                    self.actors = data.cast
                    self.castCollectionView.reloadData()
                }
            }
        })
    }

}

extension MovieDetailViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.configure(cast: actors[indexPath.row])
        return cell
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegate
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//        let movie = movies[indexPath.row]
//        performSegue(withIdentifier: "segueDetail", sender: movie)
//    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //let width = UIScreen.main.bounds.size.width
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
