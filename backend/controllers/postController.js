const Post = require('../models/Post');
const User = require('../models/User');
const path = require('path');
const fs = require('fs');

// @desc    Create a new post
// @route   POST /api/posts
// @access  Private
const createPost = async (req, res) => {
  try {
    const { caption, location, tags, mentions } = req.body;
    
    // Parse tags and mentions if they are strings
    const tagsArray = typeof tags === 'string' ? tags.split(',').map(tag => tag.trim()) : tags;
    const mentionsArray = typeof mentions === 'string' ? mentions.split(',').map(mention => mention.trim()) : mentions;

    // Handle media files
    const media = [];
    
    if (req.files && req.files.length > 0) {
      for (const file of req.files) {
        const mediaItem = {
          type: file.mimetype.startsWith('image/') ? 'image' : 'video',
          url: `/uploads/${file.mimetype.startsWith('image/') ? 'images' : 'videos'}/${file.filename}`,
        };

        // For videos, you might want to generate a thumbnail here
        if (mediaItem.type === 'video') {
          mediaItem.thumbnail = `/uploads/thumbnails/${path.parse(file.filename).name}.jpg`;
          // You would generate thumbnail here using ffmpeg or similar
        }

        media.push(mediaItem);
      }
    }

    const post = await Post.create({
      user: req.user.id,
      caption,
      media,
      location,
      tags: tagsArray,
      mentions: mentionsArray,
    });

    // Populate user data
    await post.populate('user', 'username profilePicture');

    // Add post to user's posts array
    await User.findByIdAndUpdate(req.user.id, {
      $push: { posts: post._id }
    });

    res.status(201).json({
      success: true,
      data: post,
    });
  } catch (error) {
    console.error('Create post error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while creating post',
    });
  }
};

// @desc    Get all posts (feed)
// @route   GET /api/posts
// @access  Private
const getPosts = async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const skip = (page - 1) * limit;

    // Get posts from users that the current user follows + their own posts
    const currentUser = await User.findById(req.user.id);
    const followingUsers = [...currentUser.following, req.user.id];

    const posts = await Post.find({
      user: { $in: followingUsers },
      isArchived: false,
    })
      .populate('user', 'username profilePicture')
      .populate('likes', 'username profilePicture')
      .populate('comments.user', 'username profilePicture')
      .sort({ createdAt: -1 })
      .skip(skip)
      .limit(limit);

    const total = await Post.countDocuments({
      user: { $in: followingUsers },
      isArchived: false,
    });

    res.json({
      success: true,
      data: posts,
      pagination: {
        page,
        pages: Math.ceil(total / limit),
        total,
      },
    });
  } catch (error) {
    console.error('Get posts error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while fetching posts',
    });
  }
};

// @desc    Get single post
// @route   GET /api/posts/:id
// @access  Private
const getPost = async (req, res) => {
  try {
    const post = await Post.findById(req.params.id)
      .populate('user', 'username profilePicture')
      .populate('likes', 'username profilePicture')
      .populate('comments.user', 'username profilePicture');

    if (!post) {
      return res.status(404).json({
        success: false,
        message: 'Post not found',
      });
    }

    res.json({
      success: true,
      data: post,
    });
  } catch (error) {
    console.error('Get post error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while fetching post',
    });
  }
};

// @desc    Like/unlike a post
// @route   PUT /api/posts/:id/like
// @access  Private
const likePost = async (req, res) => {
  try {
    const post = await Post.findById(req.params.id);

    if (!post) {
      return res.status(404).json({
        success: false,
        message: 'Post not found',
      });
    }

    // Check if the post has already been liked
    const alreadyLiked = post.likes.includes(req.user.id);

    if (alreadyLiked) {
      // Unlike the post
      post.likes = post.likes.filter(
        like => like.toString() !== req.user.id
      );
    } else {
      // Like the post
      post.likes.push(req.user.id);
    }

    await post.save();

    res.json({
      success: true,
      data: {
        likes: post.likes,
        likesCount: post.likes.length,
        isLiked: !alreadyLiked,
      },
    });
  } catch (error) {
    console.error('Like post error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while liking post',
    });
  }
};

// @desc    Add comment to post
// @route   POST /api/posts/:id/comment
// @access  Private
const addComment = async (req, res) => {
  try {
    const { text } = req.body;

    const post = await Post.findById(req.params.id);

    if (!post) {
      return res.status(404).json({
        success: false,
        message: 'Post not found',
      });
    }

    const comment = {
      user: req.user.id,
      text,
    };

    post.comments.push(comment);
    await post.save();

    // Populate the new comment
    await post.populate('comments.user', 'username profilePicture');

    const newComment = post.comments[post.comments.length - 1];

    res.status(201).json({
      success: true,
      data: newComment,
    });
  } catch (error) {
    console.error('Add comment error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while adding comment',
    });
  }
};

// @desc    Delete a post
// @route   DELETE /api/posts/:id
// @access  Private
const deletePost = async (req, res) => {
  try {
    const post = await Post.findById(req.params.id);

    if (!post) {
      return res.status(404).json({
        success: false,
        message: 'Post not found',
      });
    }

    // Check if user owns the post
    if (post.user.toString() !== req.user.id) {
      return res.status(403).json({
        success: false,
        message: 'Not authorized to delete this post',
      });
    }

    // Delete media files from server
    for (const media of post.media) {
      const filePath = path.join(__dirname, '..', media.url);
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
      }
    }

    await Post.findByIdAndDelete(req.params.id);

    // Remove post from user's posts array
    await User.findByIdAndUpdate(req.user.id, {
      $pull: { posts: req.params.id }
    });

    res.json({
      success: true,
      message: 'Post deleted successfully',
    });
  } catch (error) {
    console.error('Delete post error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while deleting post',
    });
  }
};

module.exports = {
  createPost,
  getPosts,
  getPost,
  likePost,
  addComment,
  deletePost,
};