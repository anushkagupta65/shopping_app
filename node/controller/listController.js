const express = require('express');
const app = express();
const List = require('../model/list');

app.use(express.json());

exports.post = async (req, res) => {
    try {
        const list = new List(req.body);
        await list.save();
        res.status(201).json({
            "message": "Item added successfully",
            "data": list,
        });
    } catch (err) {
        res.status(400).send({ error: err.message });
    }
};

exports.get = async (req, res) => {
    try {
        const list = await List.find();
        res.status(200).json({
            "message": "Items retreived successfully",
            "data": list,
        });
    }
    catch (err) {
        res.status(500).send({ error: err.message });
    }
};

exports.updateList = async (req, res) => {
    try {
        const list = await List.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true },);
        if (!list) {
            return res.status(404).send({ error: 'list not found' });
        }
        res.status(200).json({
            "message": "Item updated successfully",
            "data": list,
        });

    } catch (err) {
        res.status(400).send({ error: err.message });
    }
};

exports.deleteList = async (req, res) => {
    try {
        const list = await List.findByIdAndDelete(req.params.id);
        if (!list) {
            return res.status(404).send({ error: 'list not found' });
        }
        res.status(200).json({
            "message": "Item deleted successfully",
            "data": list,
        });
    } catch (err) {
        res.status(400).send({ error: err.message });
    }
};

module.exports = exports;