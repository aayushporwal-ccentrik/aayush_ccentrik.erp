const cds = require('@sap/cds')
const path = require('path')

cds.on('bootstrap', (app) => {
    const express = require('express')
    app.use(
        '/Images',
        express.static(
            path.join(__dirname, '../app/manageproducts/webapp/Images')
        )
    )
})

module.exports = cds.server
