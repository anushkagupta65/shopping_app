const express = require('express');
const app = express();
const Category = require('../model/category');

app.use(express.json());

exports.post = async (req, res) => {
    try {
        const category = new Category(req.body);
        await category.save();
        res.status(201).json({
            "message": "Category added successfully",
            "data": category,
        });
    } catch (err) {
        res.status(400).send({ error: err.message });
    }
};

exports.get = async (req, res) => {
    try {
        const category = await Category.find();
        res.status(200).json({
            "message": "Categories retreived successfully",
            "data": category,
        });
    }
    catch (err) {
        res.status(500).send({ error: err.message });
    }
};

module.exports = exports;