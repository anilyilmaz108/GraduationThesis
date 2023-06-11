const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const db = require('./queries')
const port = 4000

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', (request, response) => {
  response.json({ info: 'Node.js, Express, and Postgres API' })
})

app.get('/products', db.getProducts)
app.get('/products/:id', db.getProductsById)
app.post('/products', db.createProducts)
app.put('/products/:id', db.updateProducts)
app.delete('/products/:id', db.deleteProducts)

app.get('/favourites', db.getFavourites)
app.get('/favourites/:id', db.getFavouritesById)
app.post('/favourites', db.createFavourites)
app.put('/favourites/:id', db.updateFavourites)
app.delete('/favourites/:id', db.deleteFavourites)

app.get('/purchased', db.getPurchased)
app.get('/purchased/:id', db.getPurchasedById)
app.post('/purchased', db.createPurchased)
app.put('/purchased/:id', db.updatePurchased)
app.delete('/purchased/:id', db.deletePurchased)

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})

// https://medium.com/@erickwendel/generic-repository-with-typescript-and-node-js-731c10a1b98e