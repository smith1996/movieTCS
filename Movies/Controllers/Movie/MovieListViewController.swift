//
//  ViewController.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/1/20.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    let dataService = MovieDataService()
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        getMovieList()
    }
    
    func setupUI() {
        configreNavigationBar()
        configureCollectionView()
    }
    
    func configreNavigationBar() {
        navigationItem.title = "Películas"
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9215686275, green: 0.6352941176, blue: 0.262745098, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9215686275, green: 0.6352941176, blue: 0.262745098, alpha: 1)]
    }
    
    func configureCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        movieCollectionView.collectionViewLayout = layout
    }
    
    func getMovieList() {
        
        dataService.fetchMovies { (data, error) in
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if let `data` = data {
                    self.movies = data.results
                    self.movieCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "segueDetail":
            let vc = segue.destination as! MovieDetailViewController
            vc.movie = (sender as! Movie)
        default:
            break
        }
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(movie: movies[indexPath.row])
        return cell
    }
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: "segueDetail", sender: movie)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.size.width
        return CGSize(width: ((width / 2) - 30), height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
}
