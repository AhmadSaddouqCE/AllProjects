const express = require('express')
const Instruments = require('../models/ShoppingInstruments')
const multer = require('multer')
const sharp = require('sharp')
const TTask = require('../models/Ttask')
const Task = require('../models/task')


const router = new express.Router()


const upload = multer({
    limits: {
        fileSize: 1000000
    },
})

router.post('/Instruments', upload.single('upload'), async (req, res) => {
    const instru = await Instruments.find({})
    const Count = instru.length
    var i;
    if(Count!=0){
        for(i=0;i<Count;i++){
            if(instru[i].name==req.body.name){
                res.status(400).send("Unique")
                return
            }
        }
    }
    const courses = new Instruments (req.body)

    const buffer = await sharp(req.file.buffer).resize({ width: 339, height: 509 }).png().toBuffer()
    courses.avatar = buffer
    await courses.save();
    res.status(201).send(courses)
}, (error, req, res, next) => {
    res.status(400).send({ error: error.message })
})


router.post('/Instruments/getName', async (req, res) => {
 const Course = await Instruments.find();
const count = Course.length
var array= [];
var i;
for(i=0;i<count;i++){
array[i]=Course[i].name
}
var arr1=array.toString()
var q1 = arr1.split(',')
 res.send(q1.toString())


}, (error, req, res, next) => {
    res.status(400).send({ error: error.message })
})
router.post('/Instruments/count', async (req, res) => {
    const Course = await Instruments.find();
   const count = Course.length
      
    res.send(count.toString())
   
   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Instruments/Des', async (req, res) => {
    const Course = await Instruments.find();
   const count = Course.length
   var array= [];
   var i;
   for(i=0;i<count;i++){
   array[i]=Course[i].Description
   }
   var arr1=array.toString()
   var q1 = arr1.split(',')
    res.send(q1.toString())
   
   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Instruments/price', async (req, res) => {
    const Course = await Instruments.find();
   const count = Course.length
   var array= [];
   var i;
   for(i=0;i<count;i++){
   array[i]=Course[i].Price
   }
   var arr1=array.toString()
   var q1 = arr1.split(',')
   res.send(q1.toString())
   
   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

router.post('/Instruments/getImage', async (req, res) => {
    const Course = await Instruments.find();
   const count = Course.length
   var array1=[];
   var i;
   for(i=0;i<count;i++){
   array1[i]=Course[i].avatar.toString("base64")
   }
   var arr=array1.toString()
    var q= arr.split(',')
    res.send(q.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Instruments/getQuantity', async (req, res) => {
    const Course = await Instruments.find();
   const count = Course.length
   var array1=[];
   var i;
   for(i=0;i<count;i++){
   array1[i]=Course[i].Quantity
   }
   var arr=array1.toString()
    var q= arr.split(',')
    res.send(q.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Instruments/QunatityValue', async (req, res) => {
    const Instrument = await Instruments.findOne({name:req.body.CartName});
     if(Instrument){
        res.status(200).send(Instrument.Quantity.toString())
     
        return
     }
   
    res.status(400).send("False")

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

 

   router.post('/Instruments/ChangeDes', async (req, res) => {
    const Instrument = await Instruments.findOne({name:req.body.name});
     if(Instrument){
       Instrument.Description = req.body.Description
        res.status(200).send("True")
       await Instrument.save()
        return
     }
   
    res.status(400).send("False")

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Instruments/ChangePrice', async (req, res) => {
    const Instrument = await Instruments.findOne({name:req.body.name});
     if(Instrument){
       Instrument.Price = req.body.Price
        res.status(200).send("True")
       await Instrument.save()
        return
     }
   
    res.status(400).send("False")

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })
 

   router.post('/Instruments/ChangeQuantity', async (req, res) => {
    const Instrument = await Instruments.findOne({name:req.body.name});
    console.log(req.body.name)
     if(Instrument){
       Instrument.Quantity = req.body.Quantity
      await Instrument.save()
        res.status(200).send("True")
        return
     }
   
    res.status(400).send("False")

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Instruments/DeleteInstrument', async (req, res) => {
        const Tasks = await Task.find({})
        const count = Tasks.length
        var i;
        for(i=0;i<count;i++){
            const count3 = Tasks[i].CartName.length
            if(count3==0){
                continue
            }
            for(j=0;j<count3;j++){
            if(req.body.name==Tasks[i].CartName[j]){
                Tasks[i].CartName.splice(j,1)
                Tasks[i].CartImage.splice(j,1)
                Tasks[i].CartQuantity.splice(j,1)
                Tasks[i].CartPrice.splice(j,1)
                await Tasks[i].save()

            }


        }     
    }
    const Instru = await Instruments.findOneAndDelete({name:req.body.name})
    
    res.status(200).send("Deleted")
    return
   

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })
 


module.exports = router