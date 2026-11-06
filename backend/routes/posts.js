const express = require('express');
const {
  createPost,
  getPosts,
  getPost,
  likePost,
  addComment,
  deletePost,
} = require('../controllers/postController');
const { protect } = require('../middleware/auth');
const { uploadPostMedia } = require('../middleware/upload');

const router = express.Router();

router.route('/')
  .get(protect, getPosts)
  .post(protect, uploadPostMedia.array('media', 10), createPost);

router.route('/:id')
  .get(protect, getPost)
  .delete(protect, deletePost);

router.put('/:id/like', protect, likePost);
router.post('/:id/comment', protect, addComment);

module.exports = router;