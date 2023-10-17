//
//  VideoViewController.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/18.
//

import UIKit
import Alamofire
import Kingfisher

struct Video {
    let author: String
    let date: String
    let time: Int
    let thumbNail: String
    let title: String
    let link: String
    
}

class VideoViewController: UIViewController {

    
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var videoList: KakaoVideoAPI = KakaoVideoAPI(documents: [], ds: [], g: [], m: M(), meta: Meta(isEnd: false, pageableCount: 0, totalCount: 0)) // video struct를 담는 배열
    var page = 1
    var isEnd = false


    override func viewDidLoad() {
        super.viewDidLoad()

       
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        searchTableView.rowHeight = 140
        
        searchBar.delegate = self
        
    }
    
    func callRequest (query: String, page: Int) {
        
        //kakaoAPIManager라는 class에 접근
        KakaoAPIManager.shared.callRequest(type: .video, query: query) { data in
            print(data)
            self.videoList = data
            self.searchTableView.reloadData()
        }
    }
    
}


extension VideoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1 // 새로운 검색어이기 때문에 page 를 1로 변경
        videoList.documents.removeAll() // 서버통신 전에 리스트 비워주기 !!
        
        guard let query = searchBar.text else { return }

       callRequest(query: query, page: page)
        
    }
    
}


//UITableViewDataSourcePrefetching : iOS 10 이상 사용 가능한 프로토콜, cellForRowAt 메서드가 호출되기 전에 미리 호출됨.
extension VideoViewController: UITableViewDelegate, UITableViewDataSource,UITableViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는 기능
    // 1. videoList 갯수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    // 2. page count
    // 3. isEnd
    // 위 세 가지 조건을 모두 만족시킬때만 서버통신.
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if videoList.documents.count - 1 == indexPath.row && page < 15 && isEnd == false {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
        
    }
    
    // 취소 기능 : 직접 취소하는 기능을 구현해줘야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("====취소 : \(indexPaths)")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else {
            return UITableViewCell()
        }
        
        let videolist = videoList.documents[indexPath.row]
        var contents: String {
            get {
                return "\(videolist.author) | \(videolist.playTime)회\n\(videolist.datetime)"
            }
        }
        
        cell.titleLabel.text = videolist.title
        cell.contentsLabel.text = contents
        
        if let url = URL(string: videolist.thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        
        return cell
    }

}

