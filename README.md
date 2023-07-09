
# GiysiDolabı

This study aimed for end users to shop online through the mobile application channel. This study enables both users and employees in the trade sector to save time and enable them to reach and purchase the desired selected products more  easily.

## Technologies

<div align="left">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" height="40" alt="flutter logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/firebase/firebase-plain.svg" height="40" alt="firebase logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/nodejs/nodejs-original.svg" height="40" alt="nodejs logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postgresql/postgresql-original.svg" height="40" alt="postgresql logo"  />
</div>

##  Installing the Module

Express module Node.js with NPM package manager is loaded with the command:

```shell
npm install express
```
To include the module in package JSON:
```shell
npm install express --save
```
To install the Express module globally:
```shell
npm install express -g
```
To load pg module with Node.js NPM package manager:
```shell
npm install pg
```


## API Usage

### Products API Usage

#### Fetch all items

```http
  GET /api/products
```

| Parameter | Type     | Description               |
| :-------- | :------- | :------------------------- |
|  | `string` | Return all products |

#### Fetch selected item

```http
  GET /api/products/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. ID of the item to be summoned |

#### Create item

```http
  POST /api/products
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|       | `string` | Post products |

#### Update selected item

```http
  PUT /api/products/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|   `id`    | `string` | **Required**. ID of the item to update |
  
#### Delete selected item

```http
  DELETE /api/products/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|   `id`    | `string` | **Required**. ID of the item to delete |


### Favourites API Usage

#### Fetch all items

```http
  GET /api/favourites
```

| Parameter | Type     | Description               |
| :-------- | :------- | :------------------------- |
|  | `string` | Return all favourites |

#### Fetch selected item

```http
  GET /api/favourites/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. ID of the item to be summoned |

#### Create item

```http
  POST /api/favourites
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|       | `string` | Post favourite |

#### Update selected item

```http
  PUT /api/favourites/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|   `id`    | `string` | **Required**. ID of the item to update |
  
#### Delete selected item

```http
  DELETE /api/favourites/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|   `id`    | `string` | **Required**. ID of the item to delete |

### Purchased API Usage

#### Fetch all items

```http
  GET /api/purchased
```

| Parameter | Type     | Description               |
| :-------- | :------- | :------------------------- |
|  | `string` | Return all purchased |

#### Fetch selected item

```http
  GET /api/purchased/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. ID of the item to be summoned |

#### Create item

```http
  POST /api/purchased
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|       | `string` | Post purchased |

#### Update selected item

```http
  PUT /api/purchased/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|   `id`    | `string` | **Required**. ID of the item to update |
  
#### Delete selected item

```http
  DELETE /api/purchased/${id}
```

| Parameter | Type     | Description               |
| :-------- | :------- | :-------------------------------- |
|   `id`    | `string` | **Required**. ID of the item to delete |

## PostgreSQL Database

### Products Table

In the created ecommercedb database, 3 tables were used as products, 
favorites and payments. 
To create the first table, the products table, a new table was created in the 
Schemas -> public -> Tables folder, respectively. The table is named products. Right 
click on the created table and enter the names and data types given in Properties… -
> Columns, respectively. The table created in the application is as follows.
#### Name and data types of data generated for the Products table.

![Name and data types of data generated for the Products table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/products.png)

#### SQL writing of the data created for the products table.

![SQL writing of the data created for the products table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/product_table.PNG)

#### List view of data generated for the Products table.

![List view of data generated for the Products table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/products2.png)
  

### Favorites Table

To create the second table, the favorites table, a new table was created in the 
Schemas -> public -> Tables folder, respectively. The table was named favorites. 
Right click on the created table and enter the names and data types of the data in 
Properties… -> Columns. The table created in the application is as follows.

#### Name and data types of the data created for the Favorites table

![Name and data types of the data created for the Favorites table](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/favourites.png)

#### SQL writing of the data generated for the Favorites table.

![SQL writing of the data generated for the Favorites table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/fav_table.PNG)

#### List view of data generated for the Products table.

![List view of data generated for the Products table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/favourites2.png)

### Purchased Table

To create the last table, the purchased table, a new table was created in the 
Schemas -> public -> Tables folder, respectively. The table is named as purchased. 
Right click on the created table and enter the names and data types of the data in 
Properties… -> Columns. The table created in the application is as follows.

#### Name and data types of the data created for the Purchased table.

![Name and data types of the data created for the Purchased table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/purchased.png)

#### SQL writing of the data generated for the Purchased table.

![SQL writing of the data generated for the Purchased table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/purchased_table.PNG)

#### List view of data generated for the Purchased table.

![List view of data generated for the Purchased table.](https://github.com/anilyilmaz108/GraduationThesis/blob/main/Tables/purchased2.png)

## Firebase

### How to Use Firebase?

#### 1. Create a Firebase account: 
A Firebase account is required to start using 
Firebase. An account is created from the Firebase website.
#### 2. Create project:
 Go to Firebase console and create a new project.
#### 3. Add Firebase SDK: 
The Firebase SDK for the app is downloaded and added to 
the app. Firebase SDK provides apps access to Firebase services.
#### 4. Configure Firebase services:
 Configure the Firebase service that is wanted to 
use for the application from the Firebase console. For example, if user 
authentication is desired, it is necessary to configure Firebase Authentication.
#### 5. Access Firebase services: 
Make sure Firebase SDK is configured properly and 
write code to access Firebase services.

---

Required providers service for Firebase Authentication. The required providers in 
the project are Email/Password, Google and Anonymous. Additionally, SHA-1 key is 
added to project setups for login with Google. SHA-1 Required for key 
determination is printed to the terminal like the following command.

```shell
keytool -list -v -keystore {keystore_name} -alias {alias_name}
```


## Interfaces

### Login - Register

<p float="left">
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/Logo.png" height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/Splash.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/IntroFirst.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/IntroSecond.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/IntroThird.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/LoginPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/EmailLogin.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/EmailRegister.png"  height="250" width="150" />

</p>

---

### Anonymous

<p float="left">
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/Anonymous%20Homepage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/CardPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/FavouritesPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/ProfilePage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/SettingsPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/FilteringPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/DetailPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/SearchPage.png"  height="250" width="150" />

</p>

---

### Member

<p float="left">
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/UserHome.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/UserCard.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/UserFavourites.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/UserProfile.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/UserSettings.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/FilteringPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/UserDetail.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/SearchPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/UserPayment.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/Success.png"  height="250" width="150" />
</p>

---

### Dashboard

<p float="left">
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/Admin.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/AdminCRUD.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/AdminUpdate.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/SearchPage.png"  height="250" width="150" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/anilyilmaz108/GraduationThesis/blob/main/interfaces/AdminPurchased.png"  height="250" width="150" />
  
</p>

## Figma

https://www.figma.com/file/X9VzseR8h8MLWggABrRZRA/Untitled?type=design&node-id=0-1&mode=design



## Feedback

If you have any feedback, please contact us at anilyilmaz108@gmail.com.




