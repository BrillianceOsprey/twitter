import 'package:flutter/material.dart';
import 'package:twitter/Constants/Constants.dart';
import 'package:twitter/Models/Activity.dart';
import 'package:twitter/Models/user_model.dart';
import 'package:twitter/Services/database_services.dart';

class NotificationsScreen extends StatefulWidget {
  final String currentUserId;

  const NotificationsScreen({Key? key, required this.currentUserId})
      : super(key: key);
  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  List<Activity> _activities = [];

  setupActivities() async {
    List<Activity> activities =
        await DatabaseServices.getActivities(widget.currentUserId);
    if (mounted) {
      setState(() {
        _activities = activities;
      });
    }
  }

  buildActivity(Activity activity) {
    return FutureBuilder(
        future: usersRef.doc(activity.fromUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else {
            UserModel user = UserModel.fromDoc(snapshot.data);
            return Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    // TODO: network image
                    // backgroundImage: user.profilePicture.isEmpty
                    //     ? AssetImage('assets/placeholder.png')
                    //     // : NetworkImage(user.profilePicture),
                    //     : NetworkImage(user.profilePicture ?? '')
                  ),
                  title: activity.follow == true
                      ? Text('${user.name} follows you')
                      : Text('${user.name} liked your tweet'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: kTweeterColor,
                    thickness: 1,
                  ),
                )
              ],
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    setupActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          title: const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupActivities(),
          child: ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = _activities[index];
                return buildActivity(activity);
              }),
        ));
  }
}
