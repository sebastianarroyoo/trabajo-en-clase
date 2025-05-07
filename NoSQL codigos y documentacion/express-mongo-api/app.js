// Conexion a la base de datos

const express = require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const mcors=require('cors');
const app = express();
const itemRoutes=require('./routes/productoRoutes')
const port = 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

//Conexion Mongo

mongoose.conect('mongodb://localhost:27017/miapp',{
    useNewUrlParser:true,
    useUnifiedTopologt:true,
})
.then(()=>console.log("MongoDB Conectado"))
.catch(err=>console.err(err))

//rutas

app.use('api/items',itemRoutes);

app.listen(port,()=>{
    console.log(`Servidor Conectado en http://localhost:´${PORT}`);
});