const mongose=require('mongoose');

const itemSchema=new mongose.Schema([
    nombre: {type:String,require:true},
    descripcion:String,
    creadoEn:{type:Date,default:Date.now}
]);

module.exports=mongoose.model('Item',itemSchema);