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
        case .presentNewsFeed(feed: let feed, let revealedPostIds):
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds)
            }
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel ))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostIds: [Int]) -> FeedViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachements = self.photoAttachements(feedItem: feedItem)
        let isFullSized = revealedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachements, isFullSizedPost: isFullSized)
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formattedCounter(feedItem.likes?.count),
                                       comments: formattedCounter(feedItem.comments?.count),
                                       shares: formattedCounter(feedItem.reposts?.count),
                                       views: formattedCounter(feedItem.views?.count),
                                       photoAttachements: photoAttachements,
                                       sizes: sizes,
                                       postId: feedItem.postId)
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
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
    
    private func photoAttachement(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachement? {
        guard let photos = feedItem.attachments?.compactMap({ attachement in
            attachement.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: firstPhoto.srcBig,
                                                           width: firstPhoto.width,
                                                           height: firstPhoto.height)
    }
    
    private func photoAttachements(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachement] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachement? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: photo.srcBig,
                                                               width: photo.width,
                                                               height: photo.height)
        }
    }
    
}
