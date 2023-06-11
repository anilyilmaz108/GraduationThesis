const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'ecommercedb',
  password: '176369',
  port: 5432,
})

//Products CRUD
const getProducts = (request, response) => {
  pool.query('SELECT * FROM products ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getProductsById = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('SELECT * FROM products WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}


const createProducts = (request, response) => {
  const { title, subtitle, price, image, type, gender } = request.body

  pool.query('INSERT INTO products (title, subtitle, price, image, type, gender) VALUES ($1, $2, $3, $4, $5, $6)', [title, subtitle, price, image, type, gender], (error, results) => {
    if (error) {
      throw error
    }
    response.status(201).send(`User added with ID: ${results.insertId}`)
  })
}

const updateProducts = (request, response) => {
  const id = parseInt(request.params.id)
  const { title, subtitle, price, image, type, gender} = request.body

  pool.query(
    'UPDATE products SET title = $1, subtitle = $2, price = $3, image = $4, type = $5, gender = $6 WHERE id = $7',
    [title, subtitle, price, image, type, gender, id],
    (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User modified with ID: ${id}`)
    }
  )
}

const deleteProducts = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM products WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).send(`User deleted with ID: ${id}`)
  })
}

//Favourites CRUD
const getFavourites = (request, response) => {
  pool.query('SELECT * FROM favourites ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getFavouritesById = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('SELECT * FROM favourites WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}


const createFavourites = (request, response) => {
  const { user_id, fav_id} = request.body

  pool.query('INSERT INTO favourites (user_id, fav_id) VALUES ($1, $2)', [user_id, fav_id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(201).send(`User added with ID: ${results.insertId}`)
  })
}

const updateFavourites = (request, response) => {
  const id = parseInt(request.params.id)
  const { user_id, fav_id} = request.body

  pool.query(
    'UPDATE favourites SET user_id = $1, fav_id = $2 WHERE id = $3',
    [user_id, fav_id, id],
    (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User modified with ID: ${id}`)
    }
  )
}

const deleteFavourites = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM favourites WHERE fav_id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).send(`User deleted with ID: ${id}`)
  })
}

//Purchased CRUD
const getPurchased = (request, response) => {
  pool.query('SELECT * FROM purchased ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getPurchasedById = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('SELECT * FROM purchased WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const createPurchased = (request, response) => {
  const { date, customer, amount, address, products } = request.body

  pool.query('INSERT INTO purchased (date, customer, amount, address, products) VALUES ($1, $2, $3, $4, $5)', [date, customer, amount, address, products], (error, results) => {
    if (error) {
      throw error
    }
    response.status(201).send(`User added with ID: ${results.insertId}`)
  })
}

const updatePurchased = (request, response) => {
  const id = parseInt(request.params.id)
  const { date, customer, amount, address, products} = request.body

  pool.query(
    'UPDATE purchased SET date = $1, customer = $2, amount = $3, address = $4, products = $5 WHERE id = $6',
    [date, customer, amount, address, products, id],
    (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User modified with ID: ${id}`)
    }
  )
}

const deletePurchased = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM purchased WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).send(`User deleted with ID: ${id}`)
  })
}



module.exports = {
  getProducts,
  getProductsById,
  createProducts,
  updateProducts,
  deleteProducts,

  getFavourites,
  getFavouritesById,
  createFavourites,
  updateFavourites,
  deleteFavourites,

  getPurchased,
  getPurchasedById,
  createPurchased,
  updatePurchased,
  deletePurchased,
}