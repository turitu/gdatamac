//
//  AppDelegate.m
//  gdataxcode
//
//  Created by Markus Landin on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "GData.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching tjolahoppsan");
    // Insert code here to initialize your application
    
    GDataServiceGooglePhotos *photoservice = nil;
    
    photoservice = [[GDataServiceGooglePhotos alloc] init];
    [photoservice setUserAgent:@"markusapp"];
    [photoservice setShouldCacheResponseData:YES];
    [photoservice setUserCredentialsWithUsername:nil password:nil];
    
    //NSURL *feedUrl = [photoservice photoFeedURLForUserID:@"markuslandin" albumID:@"Lilltjejen"];
    NSURL *feedUrl = [GDataServiceGooglePhotos photoFeedURLForUserID:@"markuslandin"
                                                             albumID:nil albumName:nil
                                                             photoID:nil kind:nil access:nil];
    //NSURL *feedUrl = [GDataServiceGooglePhotos photoFeedURLForUserID:@"markuslandin" albumID:@"diversepublikabilder" albumName:nil photoID:nil kind:nil access:nil];
    //NSURL *feedUrl = [photoservice photoFeedURLForUserID:@"markuslandin" albumID:@"diversepublikabilder" albumName:nil photoID:nil kind:nil access:nil];
    
    //photoservice fetchFeedWithURL:<#(NSURL *)#> completionHandler <#^(GDataServiceTicket *ticket, GDataFeedBase *feed, NSError *error)handler#>
    
    GDataQueryGooglePhotos *photoquery = nil;
    //photoquery = [[GDataQueryGooglePhotos alloc] init];
    //photoquery = [GDataQueryGooglePhotos photoQueryWithFeedURL:feedUrl];
    photoquery = [GDataQueryGooglePhotos photoQueryForUserID:@"markuslandin"
                                                     albumID:nil albumName:nil photoID:nil];

    [photoservice fetchFeedWithURL:feedUrl 
                          delegate:self 
                 didFinishSelector:@selector(feedHandler:finishedWithFeed:error:)];

     //ticket = [service fetchFeedWithURL:feedURL
       //                        delegate:self
         //             didFinishSelector:@selector(entryListFetchTicket:finishedWithFeed:error:)];     
     
    [self completionCB];
}
     
     
- (void)feedHandler:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedBase *)feed error:(NSError *)error
{
    int j = 0;
    j++;
	
    if (error == nil)
	{
		GDataFeedPhoto *photofeed = (GDataFeedPhoto *)feed;
		int i;
        int nbrAlbums;
        
        nbrAlbums = [[photofeed entries] count];
		
        for (i = 0; i < nbrAlbums; i++) {
            NSString *albumName = nil;
            GDataEntryBase *entry = [[photofeed entries] objectAtIndex:i];
            //GDataEntryPhoto *photo = (GDataEntryPhoto *)entry;
            GDataEntryPhotoAlbum *album = (GDataEntryPhotoAlbum *)entry;
            albumName = [[album title] stringValue];
            NSLog(@"Album: %@", albumName);
            [entry alternateLink];
            NSString *albId = [album GPhotoID];
            
            NSLog(@"Album ID: %@", albId);
        }
        
/*		for (i = 0; i < [[vfeed entries] count]; i++)
		{
			GDataEntryBase *entry = [[vfeed entries] objectAtIndex:i];
			if (![entry respondsToSelector:@selector(mediaGroup)]) continue;
			
			GDataEntryYouTubeVideo *video = (GDataEntryYouTubeVideo *)entry;
			
			NSArray *thumbnails = [[video mediaGroup] mediaThumbnails];
			if ([thumbnails count] == 0) continue;
			
			NSString *imageURLString = [[thumbnails objectAtIndex:0] URLString];
			[self fetchEntryImageURLString:imageURLString withVideo:video];
 		}*/
	}
	else {
		NSLog(@"fetch error: %@", error);
	}    
    
}

- (void)completionCB
{
    int i = 0;
    i++;
}

@end
