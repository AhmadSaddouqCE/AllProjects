const sgMail = require('@sendgrid/mail')

const sendgridAPIKey = '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'

sgMail.setApiKey(sendgridAPIKey)

const sendWelcomeEmail = (email,name,Verify) => {
    sgMail.send({
        from: 's11819625@gmail.com',
        to: email,
        subject: 'Thanks for joining in!',
        text: `Hi ${name}, Please confirm your account using this ${Verify} number`,

    })

}


module.exports = {
    sendWelcomeEmail
}