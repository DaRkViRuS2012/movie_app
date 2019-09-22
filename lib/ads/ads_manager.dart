import 'package:firebase_admob/firebase_admob.dart';
import 'package:movie_app/ads/ads.dart';

class AdsManager {
  var _coins = 0;
  static String adId = "ca-app-pub-8183988315191327/5271182402";
  static setupAds() {
    var initOption = 1;

    switch (initOption) {
      case 1:
        Ads.init(adId, testing: true);

        Ads.video.rewardedListener = (String rewardType, int rewardAmount) {
          // setState(() {
          //   _coins += rewardAmount;
          // });
          print("gooood");
        };
        break;

      case 2:
        var eventListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.opened) print("Returned to the app.");
        };

        Ads.init(
          adId,
          keywords: <String>['ibm', 'computers'],
          contentUrl: 'http://www.ibm.com',
          childDirected: false,
          testDevices: ['Samsung_Galaxy_SII_API_26:5554'],
          testing: false,
          listener: eventListener,
        );

        break;

      case 3:
        var eventListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.closed) print("Returned to the app.");
        };

        Ads.init(adId, listener: eventListener, testing: true);

        // You can set individual settings
        Ads.keywords = ['cats', 'dogs'];
        Ads.contentUrl = 'http://www.animalsaspets.com';
        Ads.childDirected = false;
        Ads.testDevices = ['Samsung_Galaxy_SII_API_26:5554'];
        Ads.testing = true;
        Ads.bannerListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.opened) {
            print("This is the first listener.");
          }
        };

        break;

      case 4:
        Ads.init(adId);

        var eventListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.closed) print("Returned to the app.");
        };

        /// You can set the Banner, Fullscreen and Video Ads separately.

        Ads.setBannerAd(
          size: AdSize.banner,
          keywords: ['andriod, flutter'],
          contentUrl: 'http://www.andrioussolutions.com',
          childDirected: false,
          testDevices: ['Samsung_Galaxy_SII_API_26:5554'],
          listener: eventListener,
        );

        Ads.setFullScreenAd(
            keywords: ['dart', 'flutter'],
            contentUrl: 'http://www.fluttertogo.com',
            childDirected: false,
            testDevices: ['Samsung_Galaxy_SII_API_26:5554'],
            listener: (MobileAdEvent event) {
              if (event == MobileAdEvent.opened) print("Opened the Ad.");
            });

        var videoListener = (RewardedVideoAdEvent event,
            {String rewardType, int rewardAmount}) {
          if (event == RewardedVideoAdEvent.closed) {
            print("Returned to the app.");
          }
        };

        Ads.setVideoAd(
          keywords: ['dart', 'java'],
          contentUrl: 'http://www.publang.org',
          childDirected: false,
          testDevices: null,
          listener: videoListener,
        );

        break;
      case 5:
        Ads.init(adId);

        /// You can set individual settings
        Ads.keywords = ['cats', 'dogs'];
        Ads.contentUrl = 'http://www.animalsaspets.com';
        Ads.childDirected = false;
        Ads.testDevices = ['Samsung_Galaxy_SII_API_26:5554'];

        /// Can set this at the init() function instead.
        Ads.testing = true;

        break;

      case 6:
        Ads.init(adId, testing: true);

        Ads.eventListener = (MobileAdEvent event) {
          switch (event) {
            case MobileAdEvent.loaded:
              print(
                  "The Ad is loading into memory. Not necessarily displayed yet.");
              break;
            case MobileAdEvent.failedToLoad:
              print("The Ad failed to load into memory.");
              break;
            case MobileAdEvent.clicked:
              print("The Ad has been clicked and opened.");
              break;
            case MobileAdEvent.impression:
              print("The displayed Ad has 'changed' to a new one.");
              break;
            case MobileAdEvent.opened:
              print("The Ad is now open.");
              break;
            case MobileAdEvent.leftApplication:
              print("You've left the app after clicking the Ad.");
              break;
            case MobileAdEvent.closed:
              print("You've closed the Ad and returned to the app.");
              break;
            default:
              print("There's a 'new' MobileAdEvent?!");
          }
        };

        break;

      case 7:
        Ads.init(adId, testing: true);

        Ads.showBannerAd();

        Ads.bannerListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.opened) {
            print("You've clicked on the Banner Ad");
          }
        };

        Ads.screenListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.opened) {
            print("You've clicked on the Fullscreen Ad.");
          }
        };

        Ads.videoListener = (RewardedVideoAdEvent event,
            {String rewardType, int rewardAmount}) {
          if (event == RewardedVideoAdEvent.opened) {
            print("You've clicked on the Fullscreen Ad.");
          }
        };

        break;
      case 8:
        Ads.init(adId, testing: true);

        Ads.banner.openedListener = () {
          print("This is the first listener when you open the banner ad.");
        };

        Ads.banner.openedListener = () {
          print("This is the second listener when you open the banner ad.");
        };

        Ads.banner.leftAppListener = () {
          print("You've left your app.");
        };

        Ads.banner.closedListener = () {
          print("You've closed an ad and returned to your app.");
        };

        break;
      case 9:
        Ads.init(adId, testing: true);

        Ads.screen.openedListener = () {
          print("This is the first listener when you open the full screen ad.");
        };

        Ads.screen.openedListener = () {
          print(
              "This is the second listener when you open the full screen ad.");
        };

        Ads.screen.leftAppListener = () {
          print("You've left your app.");
        };

        Ads.screen.closedListener = () {
          print("You've closed an ad and returned to your app.");
        };

        break;
      case 10:
        Ads.init(adId, testing: true);

        Ads.video.closedListener = () {
          print("You've closed the video.");
        };

        Ads.video.rewardedListener = (String rewardType, int rewardAmount) {
          // setState(() {
          //   _coins += rewardAmount;
          // });

          print("Awwwwwooosem");
        };

        break;

      default:
        Ads.init(adId, testing: true);
    }

    var one = Ads.appId;
    var two = Ads.keywords;
    var three = Ads.contentUrl;

    var seven = Ads.childDirected;
    var eight = Ads.testDevices;
    var nine = Ads.testing;
  }

  static void showAd() async {
    String adType = 'screen';

    switch (adType) {
      case 'screen':
        Ads.showFullScreenAd();
        break;
      case 'video':
        Ads.showVideoAd();
        break;
      default:
        Ads.showBannerAd();
    }
  }

  static void showBannerAd() {
    Ads.showBannerAd();
  }
}
