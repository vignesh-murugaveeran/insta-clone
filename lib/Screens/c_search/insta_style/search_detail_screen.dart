import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchDetailScreen extends StatefulWidget {
  const SearchDetailScreen({super.key});

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Sample data
  final List<Map<String, dynamic>> _searchCategories = [
    {'title': 'IGTV', 'icon': Icons.live_tv_rounded, 'color': Colors.purple},
    {'title': 'Shop', 'icon': Icons.shopping_bag_rounded, 'color': Colors.blue},
    {'title': 'Style', 'icon': Icons.style_rounded, 'color': Colors.pink},
    {
      'title': 'Sports',
      'icon': Icons.sports_baseball_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'Auto',
      'icon': Icons.directions_car_rounded,
      'color': Colors.red,
    },
  ];

  final List<String> _recentSearches = [
    'flutter',
    'instagram clone',
    'ui design',
    'dart programming',
    'mobile development',
  ];

  final List<Map<String, dynamic>> _trendingAccounts = [
    {
      'username': 'tech_guru',
      'name': 'Tech Guru',
      'image': img1,
      'isVerified': true,
    },
    {
      'username': 'travel_diaries',
      'name': 'Travel Diaries',
      'image': img2,
      'isVerified': false,
    },
    {
      'username': 'foodie_world',
      'name': 'Foodie World',
      'image': img1,
      'isVerified': true,
    },
  ];

  bool _isSearching = false;
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    // Auto focus when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (_isSearching) {
        _performSearch(query);
      }
    });
  }

  void _performSearch(String query) {
    _searchResults = [
      {
        'type': 'account',
        'username': query,
        'name': '${query.capitalize!} Official',
        'image': img1,
        'isVerified': true,
        'followers': '1.2M followers',
      },
      {
        'type': 'hashtag',
        'tag': '#${query.toLowerCase()}',
        'posts': '245K posts',
      },
      {
        'type': 'audio',
        'title': '${query.capitalize!} Sound',
        'artist': 'Various Artists',
        'plays': '45K plays',
      },
      {
        'type': 'place',
        'name': '${query.capitalize!} Location',
        'address': 'New York, NY',
      },
    ];
  }

  void _clearSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
    setState(() {
      _isSearching = false;
    });
  }

  void _addToRecentSearches(String query) {
    if (!_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      });
    }
  }

  void _removeRecentSearch(String query) {
    setState(() {
      _recentSearches.remove(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar with autofocus
            _buildSearchBar(),

            // Body Content
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildExploreContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(1),
              child: TextField(
                autofocus: true, // ← THIS ENABLES AUTOFOCUS
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.close, color: Colors.grey.shade600),
                          onPressed: _clearSearch,
                        )
                      : null,
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    _addToRecentSearches(value.trim());
                  }
                },
              ),
            ),
          ),
          12.widthBox,
          Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ).onTap(() {
            Navigator.pop(context); // Go back
          }),
        ],
      ),
    );
  }

  // ... rest of your _buildExploreContent(), _buildSearchResults() methods ...
  // (keep them exactly as you have them)
  Widget _buildExploreContent() {
    return CustomScrollView(
      slivers: [
        // Categories Section

        //Recent Searches Section
        if (_recentSearches.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Searches',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ).onTap(() {
                        // Handle see all
                      }),
                    ],
                  ),
                  12.heightBox,
                  Column(
                    children: _recentSearches.map((search) {
                      return ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                        ),
                        title: Text(search),
                        trailing: Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.grey.shade600,
                        ).onTap(() {}),
                        onTap: () {
                          _searchController.text = search;
                          _addToRecentSearches(search);
                        },
                        onLongPress: () => _removeRecentSearch(search),
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

        //Trending Accounts Section
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trending Accounts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                12.heightBox,
                Column(
                  children: _trendingAccounts.map((account) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(account['image']),
                      ),
                      title: Row(
                        children: [
                          Text(
                            account['username'],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          4.widthBox,
                          if (account['isVerified'] as bool)
                            Icon(Icons.verified, color: Colors.blue, size: 16),
                        ],
                      ),
                      subtitle: Text(account['name']),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        //Navigate to profile
                        print('Navigate to ${account['username']} profile');
                      },
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];

        switch (result['type']) {
          case 'account':
            return _buildAccountResult(result);
          case 'hashtag':
            return _buildHashtagResult(result);
          case 'audio':
            return _buildAudioResult(result);
          case 'place':
            return _buildPlaceResult(result);
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildAccountResult(Map<String, dynamic> account) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(account['image']),
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 7),
        child: Row(
          children: [
            Text(
              account['username'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            4.widthBox,
            if (account['isVerified'] as bool)
              Icon(Icons.verified, color: Colors.blue, size: 16),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(account['name']),
          Text(
            account['followers'],
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'Follow',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: () {
        _addToRecentSearches(account['username']);
        // Navigate to profile
        print('Navigate to ${account['username']} profile');
      },
    );
  }

  Widget _buildHashtagResult(Map<String, dynamic> hashtag) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(Icons.tag, color: Colors.grey.shade600),
      ),
      title: Text(
        hashtag['tag'],
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        hashtag['posts'],
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      onTap: () {
        _addToRecentSearches(hashtag['tag']);
        // Navigate to hashtag page
        print('Navigate to ${hashtag['tag']} page');
      },
    );
  }

  Widget _buildAudioResult(Map<String, dynamic> audio) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(Icons.music_note, color: Colors.grey.shade600),
      ),
      title: Text(
        audio['title'],
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(audio['artist']),
          Text(
            audio['plays'],
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
      trailing: Icon(Icons.play_arrow_rounded, color: Colors.grey.shade600),
      onTap: () {
        _addToRecentSearches(audio['title']);
        // Play audio
        print('Play ${audio['title']}');
      },
    );
  }

  Widget _buildPlaceResult(Map<String, dynamic> place) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(Icons.location_on, color: Colors.grey.shade600),
      ),
      title: Text(place['name'], style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        place['address'],
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      onTap: () {
        _addToRecentSearches(place['name']);
        // Navigate to location page
        print('Navigate to ${place['name']} location');
      },
    );
  }
}
