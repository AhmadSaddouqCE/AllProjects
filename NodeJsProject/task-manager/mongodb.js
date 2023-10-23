// const mongodb = require('mongodb')
// const MongoClient = mongodb.MongoClient // connect to database

// const ObjectID = mongodb.ObjectID

const { MongoClient, ObjectId} = require('mongodb')


const connectionURL = 'mongodb://0.0.0.0:27017/'
const databaseName = 'task-manager'

MongoClient.connect(connectionURL,{ useNewUrlParser: true,
}, (error, client)=> {
if(error){
    return console.log('Unable to connect to database')
}


// Create --------------------------------------
// db.collection('users').insertOne({
//     _id: id,
//  name: 'Ehab',
//  age: 26  
// }, (error, result) => {
// if(error){
//     return console.log('Unable to insert user')
// }
// console.log(result.insertedId)
// })

// // db.collection('users').insertMany([
// //     {
// //         name: 'jen',
// //         age: 28
// //     }, {
// //         name :'ahmad',
// //         age:28
// //     }
// // ], (error, result)=>{
// // if(error){
// //     return console.log('Unable to insert documents')
// // }
// // console.log(result.ops)
// // })
 
// // db.collection('tasks').insertMany([
// //     {
// //         description: 'Ahmad',
// //         completed : true
// //     }, {
// //         description : 'Ehab',
// //         completed: false
// //     }, {
// //         description : 'Hey bro',
// //         completed: true
// //     }
// // ], (error, result)=>{
// //     if(error){
// //         return console.log('Unable to insert these documents!')
// //     }
// //     return console.log(result.ops)
// // }) //------------------

//Read-------------

// db.collection('users').find({age: 28}).toArray((error, users)=>{
// console.log(users)
// })

//---Update 

// db.collection('users').updateOne({
//     _id: new ObjectId("61feb89443fcbe47e697919c")
// }, {
//     $set: {
//         name : 'Kelo1'
//     }
// }).then((result)=>{
// console.log(result)
// }).catch((error)=>{
// console.log(error)
// }) 

// db.collection('tasks').updateMany({
//     completed: false
// }, {
//     $set: {
//         completed: true 
//     }
// }).then((result)=>{
// console.log(result)
// }).catch(()=>{
//     console.log(error)
// })
db.collection('tasks').deleteOne({
     description: 'Ehab'
}).then((result)=>{
    console.log(result)
}).catch((error)=>{
    console.log(error)
})

})