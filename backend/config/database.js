const mongoose = require('mongoose');

const connectDB = async () => {
    try {
        const connect = await mongoose.connect(process.env.MONGO_URI);
        console.log(`MongoDB Connected: ${connect.connection.host}`);
        console.log(`database name: ${connect.connection.name}`);
    } catch (error) {
        console.error(`Database conn Error: ${error.message}`);
        process.exit(1);
    }
};

module.exports = connectDB;