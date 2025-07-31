const mongoose = require('mongoose');

const listSchema = new mongoose.Schema({
    item: {
        type: String,
        required: true
    },
    quantity: {
        type: String,
        required: true,
    },
    category: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Category', // 👈 refers to Category model
    },
    // category: {
    //     type: String,
    //     enum: ['dairy', 'fruits', 'vegetables', 'electronics', 'personal_care', 'household_essentials', 'pharmacy', '',]
    // },
    priceRange: { type: String },
    status: {
        type: String,
        enum: ['purchased', 'not_purchased'],
        default: 'not_purchased'
    }
});

const list = mongoose.model('List', listSchema);
module.exports = list;