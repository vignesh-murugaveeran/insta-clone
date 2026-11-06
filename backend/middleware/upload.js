const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Ensure upload directories exist
const createUploadDirs = () => {
  const dirs = [
    'uploads/images',
    'uploads/videos',
    'uploads/thumbnails'
  ];
  
  dirs.forEach(dir => {
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
  });
};

createUploadDirs();

// Storage configuration for images
const imageStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/images/');
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'image-' + uniqueSuffix + path.extname(file.originalname));
  }
});

// Storage configuration for videos
const videoStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/videos/');
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'video-' + uniqueSuffix + path.extname(file.originalname));
  }
});

// File filter for images
const imageFileFilter = (req, file, cb) => {
  if (file.mimetype.startsWith('image/')) {
    cb(null, true);
  } else {
    cb(new Error('Only image files are allowed!'), false);
  }
};

// File filter for videos
const videoFileFilter = (req, file, cb) => {
  if (file.mimetype.startsWith('video/')) {
    cb(null, true);
  } else {
    cb(new Error('Only video files are allowed!'), false);
  }
};

// File size limits
const limits = {
  image: {
    fileSize: 10 * 1024 * 1024, // 10MB for images
  },
  video: {
    fileSize: 100 * 1024 * 1024, // 100MB for videos
  }
};

// Multer instances
const uploadImage = multer({
  storage: imageStorage,
  fileFilter: imageFileFilter,
  limits: limits.image,
});

const uploadVideo = multer({
  storage: videoStorage,
  fileFilter: videoFileFilter,
  limits: limits.video,
});

// Multiple file upload for posts (images and videos)
const uploadPostMedia = multer({
  storage: multer.diskStorage({
    destination: (req, file, cb) => {
      if (file.mimetype.startsWith('image/')) {
        cb(null, 'uploads/images/');
      } else if (file.mimetype.startsWith('video/')) {
        cb(null, 'uploads/videos/');
      }
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
      const prefix = file.mimetype.startsWith('image/') ? 'image-' : 'video-';
      cb(null, prefix + uniqueSuffix + path.extname(file.originalname));
    }
  }),
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
      cb(null, true);
    } else {
      cb(new Error('Only image and video files are allowed!'), false);
    }
  },
  limits: {
    fileSize: 100 * 1024 * 1024, // 100MB per file
  }
});

module.exports = {
  uploadImage,
  uploadVideo,
  uploadPostMedia,
};