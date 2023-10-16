// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twitter/Models/user_model.dart';
import 'package:twitter/Screens/profile_screen.dart';
import 'package:twitter/Services/database_services.dart';

class SearchScreen extends StatefulWidget {
  final String currentUserId;

  const SearchScreen({Key? key, required this.currentUserId}) : super(key: key);
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot<Object?>>? _users;
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> userList = [];

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }

  buildUserTile(UserModel user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: user.profilePicture.isEmpty
            ? const AssetImage('assets/placeholder.png')
            : NetworkImage(user.profilePicture) as ImageProvider,
      ),
      title: Text(user.name),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  currentUserId: widget.currentUserId,
                  visitedUserId: user.id,
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            hintText: 'Search Twitter...',
            hintStyle: const TextStyle(color: Colors.white),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                clearSearch();
              },
            ),
            filled: true,
          ),
          onChanged: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _users = DatabaseServices.searchUsers(input);
              });
            }
          },
        ),
      ),
      body: _users == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 200),
                  Text(
                    'Search Twitter...',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          : FutureBuilder(
              future: _users,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                _users!.then((value) {
                  // userList = value.docs;
                  userList.clear();
                  for (var element in value.docs) {
                    userList.add(UserModel.fromSnapshot(element));
                  }
                  print('search screen search controller userList $userList');
                });
                if (userList.isEmpty) {
                  return const Center(
                    child: Text('No users found!'),
                  );
                }
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // UserModel user =
                      //     UserModel.fromDoc(snapshot.data.documents[index]);
                      return buildUserTile(userList[index]);
                    });
              }),
    );
  }
}
