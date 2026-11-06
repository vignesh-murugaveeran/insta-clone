import 'package:flutter/material.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/consts/list.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: 'Settings and Activity'.text.size(20).make(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.transparent,
                  alignment: Alignment.center,
                  height: 45,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                    // boxShadow: [
                    //   BoxShadow(color: Colors.black12, blurRadius: 10),
                    // ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onTap: () {}, //controller.toggleSearch(),
                  ),
                ),
                14.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          'Your account'.text.size(15).make(),
                          const Spacer(),
                          Row(
                            children: [
                              Image.asset(ic3, width: 20),
                              3.widthBox,
                              'Meta'.text.size(17).make(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                17.heightBox,
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.account_circle_outlined),
                        title: 'Accounts Centre'.text.make(),
                        subtitle:
                            'Password, security, personal details, ad preferences'
                                .text
                                .maxLines(2)
                                // .overflow(TextOverflow.ellipsis)
                                .make(),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Manage your connected experiences and account settings across Meta teechnologies. Learn more',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                10.heightBox,
                const Divider(thickness: 5),
                5.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'How you use Instagram',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                10.heightBox,
                SizedBox(
                  height: 250,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(howUseInsta['icon']!.length, (
                      index,
                    ) {
                      return SizedBox(
                        height: 48,
                        child: ListTile(
                          //dense: true,
                          //visualDensity: VisualDensity.compact,
                          //visualDensity: VisualDensity(vertical: -3, horizontal: 0),
                          leading: howUseInsta['icon']![index],
                          title: howUseInsta['iconText']![index]
                              .toString()
                              .text
                              .make(),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                //10.heightBox,
                const Divider(thickness: 5),
                5.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Who can see use content',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                10.heightBox,
                SizedBox(
                  height: 250,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(whoSeeContent['icon']!.length, (
                      index,
                    ) {
                      return SizedBox(
                        height: 48,
                        child: ListTile(
                          //dense: true,
                          //visualDensity: VisualDensity.compact,
                          //visualDensity: VisualDensity(vertical: -3, horizontal: 0),
                          leading: whoSeeContent['icon']![index],
                          title: whoSeeContent['iconText']![index]
                              .toString()
                              .text
                              .make(),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const Divider(thickness: 5),
                5.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Log out'.text
                          .size(16)
                          .color(Colors.red)
                          .make()
                          .onTap(() {}),
                      25.heightBox,
                      'Log out of all account'.text
                          .size(16)
                          .color(Colors.red)
                          .make()
                          .onTap(() {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
