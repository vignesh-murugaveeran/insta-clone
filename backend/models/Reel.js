const mongoose = require('mongoose');

const reelSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    video: {
        url: {
            type: String,
            required: true,
        },
        thumnail: {
            type: String,

            required: true,
        },
        duration: {
            type: Number, // Duration in seconds
            required: true,
        },
        size: {
            type: Number, // Size in bytes
            required: true,
        },
    },
    audio: {
        name: {
            type: String,
        },
        artist: {
            type: String,
        },
        url: {
            type: String,
        },
    },
    caption: {
        type: String,
        maxlength: [2200, 'caption cannot exceed 2200 characters'],
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
    }],
    comments: [{
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            maxlength: [1000, 'Comment cannot exceed 1000 characters'],
        },
        text: {
            type: String,
            required: true,
            maxlength: [1000, 'Comment cannot exceed 1000 characters'],
        },
        createdAt: {
            type: Date,
            default: Date.now,
        }
    }],
    views: {
        type: Number,
        default: 0,
    },
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
reelSchema.index({user: 1, createdAt: -1});
reelSchema.index({likes: -1});
reelSchema.index({tags: 1});

module.exports = mongoose.model('Reel', reelSchema);
