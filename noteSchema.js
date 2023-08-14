var mongoose = require("mongoose")
var Schema = mongoose.Schema

var note = new Schema({

    title: String,
    date: String,
    note: String

})

const Data = mongoose.model("Data", note) //create data object that is the node schema

module.exports = Data // able to send this schema to the server.js