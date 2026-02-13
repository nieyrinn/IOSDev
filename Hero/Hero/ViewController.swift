import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    func fetchSuperheroData(completion: @escaping (Result<[Superhero], Error>) -> Void) {
        guard let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let superheroes = try JSONDecoder().decode([Superhero].self, from: data)
                completion(.success(superheroes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }



}

