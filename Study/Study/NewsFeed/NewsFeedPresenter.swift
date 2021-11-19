//
//  NewsFeedPresenter.swift
//  Study
//
//  Created by Лолита Чернышева on 15.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//MARK: - todo
//избавиться от опционала на 50 строке
import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMMM 'в' HH:mm"
        return dt
    }()
    
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(feed: let feed):
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
            }
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachement = self.photoAttachemen(feedItem: feedItem)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachement)
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachement: photoAttachement,
                                       sizes: sizes)
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        //определяем, что получаем: группу или пользователя
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        //возвращаем нормальный (положительный) знак для sourceId
        let noramalSourceId = sourceId >= 0 ? sourceId : -sourceId
        //получаем информацию о текущем посте
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == noramalSourceId
        }
        return profileRepresentable!
    }
    
    private func photoAttachemen(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachement? {
        guard let photos = feedItem.attachments?.compactMap({ attachement in
            attachement.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: firstPhoto.srcBig,
                                                           width: firstPhoto.width,
                                                           height: firstPhoto.height)
    }
    
}
