import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() {}

    func fetchData(completion: @escaping (Result<RootResponse, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/nieyrinn/AlmatyGo/main/data.json")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error));
                return }
            guard let data = data else {
                completion(.failure(NSError()));
                return }

            do {
                let decoded = try JSONDecoder().decode(RootResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
