import 'package:blog_app/model/follow.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/ui/screen/blog/blog_detail.dart';
import 'package:blog_app/ui/screen/blog/create_blog.dart';
import 'package:blog_app/ui/screen/profile/edit_profile.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/viewmodel/account_viewmodel.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:blog_app/viewmodel/follow_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../model/account.dart';
import '../../../model/blog.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key, required this.email});
  String email = "";
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  AccountViewModel accountViewModel = AccountViewModel();
  BlogViewmodel blogViewModel = BlogViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder(
                future: accountViewModel.getByEmail(widget.email),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Container(height: 200, child: _TopPortion(snapshot.data)),
                      Container(
                        height: 220,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data?.name ?? "Richie Lorie",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              if(widget.email != SaveAccount.currentEmail)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    this.genFollowButton(widget.email),
                                    const SizedBox(width: 16.0),
                                    FloatingActionButton.extended(
                                      onPressed: () {},
                                      heroTag: 'Block',
                                      elevation: 0,
                                      backgroundColor: Colors.red,
                                      label: const Text("Block"),
                                      icon: const Icon(Icons.block),
                                    ),
                                  ],
                                )
                              else
                                UI_CONST.SIZEDBOX30,
                              const SizedBox(height: 16),
                              _ProfileInfoRow(widget.email)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
              StreamBuilder(
                  stream: blogViewModel.getPostsByEmail(widget.email), builder: (context, snapshot) {
                    List<Blog> blogs = snapshot.data ?? [];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: blogs.length,
                        itemBuilder: (context, index) {
                          return ABlogDetail(blogs[index]);
                        },
                    );
                  },),
              //StreamBuilder(stream: stream, builder: builder)
            ],
          ),
        ),
          Positioned(
            top: 16,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 16,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => EditProfile(),);
                Navigator.push(context, route);
              },
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => CreateBlog(),);
          Navigator.push(context, route);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }

  Widget genFollowButton(String followingEmail) {
    FollowViewmodel viewmodel = FollowViewmodel();
    return StreamBuilder<bool>(
      stream: viewmodel.checkFollow( SaveAccount.currentEmail!, followingEmail),
      builder: (context, snapshot) {
        bool state = false;
        String followText = "Follow";
        Color backgroundColor = DefaultSelectionStyle.defaultColor;
        IconData iconData = Icons.person_add_alt_1;
        if (snapshot.hasData){
          if (snapshot.data == true){
            state = snapshot!.data!;
            followText = "Followed";
            backgroundColor = Colors.green;
            iconData = Icons.person_2_outlined;
          }
        }

        return FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              if (state == true){
                viewmodel.delete(followingEmail);
              }
              else{
                viewmodel.add(Follow("id", SaveAccount.currentEmail!, followingEmail));
              }
            });
          },
          elevation: 0,
          heroTag: 'Follow',
          label: Text(followText),
          icon: Icon(iconData),
          backgroundColor: backgroundColor,
        );
      }
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final String email;
  FollowViewmodel followViewmodel = FollowViewmodel();
  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 100),
    ProfileInfoItem("Following", 200),
  ];

  _ProfileInfoRow(this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
            child: Row(
              children: [
                if (_items.indexOf(item) != 0) const VerticalDivider(),
                Expanded(child: _singleItem(context, item)),
              ],
            )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Text(
        item.title,
        style: Theme.of(context).textTheme.caption,
      )
    ],
  );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  Account? account;
  AccountViewModel viewModel = AccountViewModel();

  _TopPortion(Account? this.account, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              account?.avatarPath == "" ? STRING_CONST.NETWORKIMAGE_DEFAULT
                                  : (account?.avatarPath ?? STRING_CONST.NETWORKIMAGE_DEFAULT)
                          )
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
