//
//  ViewController.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/18.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Movie {
    var movieTitle: String
    var releaseDate: String
}


class ViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var movieTableView: UITableView!
    
    //var movieList: [Movie] = []
    //codable
    var result: BoxOffice?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.rowHeight = 60

        indicatorView.isHidden = true
        
        
    }

    func callRequest(date: String) {
        
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        

        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: BoxOffice.self
           /*모든 데이터를 포괄하는 가장 큰 구조체 가져오기*/) { response in
                print(response.value)
                self.result = response.value
    
            }
        
        
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
        
//                let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let name3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//                //데이터 가져오기
//
//                print(name1, name2, name3)
//
//                self.movieList.append(contentsOf: [name1, name2, name3]) // 배열에 추가.
//
//                self.movieTableView.reloadData() // 테이블뷰 데이터 갱신 !
//
//                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//
//                    let movieNM = item["movieNm"].stringValue
//                    let releaseDT = item["openDt"].stringValue
//
//                    let data = Movie(movieTitle: movieNM, releaseDate: releaseDT)
//                    self.movieList.append(data)
//
//                }
//
//                self.indicatorView.stopAnimating()
//                self.indicatorView.isHidden = true
//                self.movieTableView.reloadData()
//
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
    }

}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //20220101 > 1. 8글자만 입력되어야 함  2. 20233333 올바른 날짜인지  3. 날짜 범주 (어제 날짜까지만 들어가야 함)
        
        //movieList.removeAll()
        callRequest(date: searchBar.text!)
        print("먼디")
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.boxOfficeResult.dailyBoxOfficeList.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        
        cell.textLabel?.text = result?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        cell.detailTextLabel?.text = result?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].openDt
        
    
        return cell
    }
    
    
    
    
    
}
