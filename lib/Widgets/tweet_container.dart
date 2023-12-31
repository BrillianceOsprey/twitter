import 'package:flutter/material.dart';
import 'package:twitter/Constants/Constants.dart';
import 'package:twitter/Models/Tweet.dart';
import 'package:twitter/Models/user_model.dart';
import 'package:twitter/Services/database_services.dart';

class TweetContainer extends StatefulWidget {
  final Tweet tweet;
  final UserModel author;
  final String currentUserId;

  const TweetContainer(
      {Key? key,
      required this.tweet,
      required this.author,
      required this.currentUserId})
      : super(key: key);
  @override
  TweetContainerState createState() => TweetContainerState();
}

class TweetContainerState extends State<TweetContainer> {
  int _likesCount = 0;
  bool _isLiked = false;

  initTweetLikes() async {
    bool isLiked =
        await DatabaseServices.isLikeTweet(widget.currentUserId, widget.tweet);
    if (mounted) {
      setState(() {
        _isLiked = isLiked;
      });
    }
  }

  likeTweet() {
    if (_isLiked) {
      DatabaseServices.unlikeTweet(widget.currentUserId, widget.tweet);
      setState(() {
        _isLiked = false;
        _likesCount--;
      });
    } else {
      DatabaseServices.likeTweet(widget.currentUserId, widget.tweet);
      setState(() {
        _isLiked = true;
        _likesCount++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _likesCount = widget.tweet.likes;
    initTweetLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: widget.author.profilePicture.isEmpty
                    ? const AssetImage('assets/placeholder.png')
                    : NetworkImage(widget.author.profilePicture)
                        as ImageProvider,
              ),
              const SizedBox(width: 10),
              Text(
                widget.author.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            widget.tweet.text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          widget.tweet.image.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: kTweeterColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.tweet.image),
                          )),
                    )
                  ],
                ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.blue : Colors.black,
                    ),
                    onPressed: likeTweet,
                  ),
                  Text(
                    '$_likesCount Likes',
                  ),
                ],
              ),
              Text(
                widget.tweet.timestamp.toDate().toString().substring(0, 19),
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 10),
          const Divider()
        ],
      ),
    );
  }
}
