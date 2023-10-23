const fs = require('fs')
// const book = {
//     title : 'Ego is the Enemy',
//     author: 'Ryan Holiday'
// }

// const bookJSON= JSON.stringify(book)
// fs.writeFileSync('1-json.json', bookJSON)

// const dataBuffer = fs.readFileSync('1-json.json')
// const dataJSON = dataBuffer.toString()
// const data = JSON.parse(dataJSON)
// console.log(data.title)
const JSONData = fs.readFileSync('1-json.json')
const dataBuffer1 = JSONData.toString()
const Parsing = JSON.parse(dataBuffer1)
Parsing.name = 'Ahmad'
Parsing.age = 20
const userJSON = JSON.stringify(Parsing) 
fs.writeFileSync('1-json.json', userJSON)
// console.log(bookJSON)
// const ParseData = JSON.parse(bookJSON)
// console.log(ParseData.author)