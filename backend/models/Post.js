const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    caption: {
        type: String,
        maxlength: [2200, 'Caption cannot exceed 2200 characters'],
    },
    media: [{
        type: {
            type: String,
            enum: ['image', 'video'],
            required: true,
        },
        url: {
            type: String,
            required: true,
        },
        thumbnail: {
            type: String, // For video thumbnails
        },
        duration: {
            type: Number, // Duration in seconds for videos
        },
    }],
    location: {
        type: String,
    },
    tags: [{
        type: String,
    }],
    mentions: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    }],
    likes: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    }],
    comments: [{
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true,
        },
        text: {
            type:String,
            required: true,
            maxlength: [1000, 'Comment cannot exceed 1000 characters'],
        },
        createdAt: {
            type: Date,
            default: Date.now,
        },
    }],
    saves: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    }],
    shares: {
        type: Number,
        default: 0,
    },
    isArchived: {
        type: Boolean,
        default: false,
    },
},{timestamps: true});

//Index for better performance
postSchema.index({user: 1, createdAt: -1});
postSchema.index({likes: -1});
postSchema.index({tags: 1});

module.exports = mongoose.model('Post', postSchema);