import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsivechat/ConversationPage.dart';
import 'package:responsivechat/widgets/ConversationListItem.dart';

import 'models/ChatApp.dart';
import 'models/Conversation.dart';
import 'models/User.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 1
    var hasDetailPage =
        MediaQuery.of(context).orientation == Orientation.landscape;
// 2
    Widget child;

    if (hasDetailPage) {
      // 3
      child = Row(
        children: [
          // 4
          SizedBox(
            width: 250,
            height: double.infinity,
            child: _buildList(context, hasDetailPage),
          ),
          // 5
          Expanded(child: _buildChat(context, selectedIndex)),
        ],
      );
    } else {
      // 6
      child = _buildList(context, hasDetailPage);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: SafeArea(
        // 7
        child: child,
      ),
    );
  }

  _buildList(BuildContext context, bool hasDetailPage) {
    var chat = Provider.of<ChatApp>(context);

    return ListView.separated(
      itemCount: chat.conversations.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black.withAlpha(50),
      ),
      itemBuilder: (context, index) {
        Conversation conversation = chat.conversations[index];
        List<User> users =
            conversation.senderIds.map((id) => chat.users[id]).toList();
        String userNames = users.map((user) => user.name).join(", ");

        return GestureDetector(
          onTap: () {
            if (hasDetailPage) {
              setState(() {
                selectedIndex = index;
              });
            } else {
              Navigator.pushNamed(
                context,
                "/chat",
                arguments: {"index": index},
              );
            }
          },
          child: ConversationListItem(
              userNames: userNames, conversation: conversation),
        );
      },
    );
  }

  _buildChat(BuildContext context, int index) {
    var chat = Provider.of<ChatApp>(context);

    Conversation conversation = chat.conversations[index];
    return Container(
      color: Colors.black.withAlpha(10),
      child: ConversationPage(
        isDetail: true,
        conversation: conversation,
      ),
    );
  }
}
