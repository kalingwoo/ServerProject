const express = require('express')
const mongoose = require('mongoose')
var app = express()
var Data = require('./noteSchema')

mongoose.connect('mongodb://localhost/newDB')

mongoose.connection.once("open", () => {
    console.log("Connected to DB!")
}).on("error", (error) => {
    console.log("Failed to connect " + error )
})

// create a note
// POST request (sending(posting) something to the server)
app.post("/create", (req, res) => {

    var note = new Data ({

        note: req.get("note"), 
        title: req.get("title"),
        date: req.get("date"),
    })

    note.save().then(()=> {

        if(note.isNew == false){ //if its equals to true, means the data only saved on the server and failed to save on the database 

            console.log("Saved data!")
            res.send("Saved data") //tell the ipone we received the data

        }else{
            console.log("failed to save data")
        }

    })
})

// fetch all note
// GET request (getting sth form the server)
app.get('/fetch', (req, res) => {

    Data.find({}).then((DBitems)=>{
        res.send(DBitems)
    })

})

// delete a note
// POST request 
app.post("/delete", async (req, res) => {
    await Data.findOneAndRemove({
        _id: req.get("id")
    })

    res.send("Deleted!")
})


// update a note
// POST request 
app.post('/update', async(req,res)=>{

    await Data.findOneAndUpdate({
        _id: req.get("id") //object we want to update
    }, {
        note: req.get("note"), //sending new data
        title: req.get("title"),
        date: req.get("date")
    })
    res.send("Updated")
})


//http://10.10.4.4:8081/create 

var server = app.listen(8081, "10.10.4.4", () => {

    console.log("Sever is running!")

})





