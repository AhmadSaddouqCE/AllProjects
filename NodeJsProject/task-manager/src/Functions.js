const User = require('./models/user')

const   deletemmany = async() =>{

    const user = this
    await User.findOneAndRemove({owenr : user._id})

}

module.exports = {
    deletemmany
}