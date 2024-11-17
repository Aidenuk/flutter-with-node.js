
const express = require('express');
const mongoose = require('mongoose');
const app = express();
const PORT = 4000;
const DB = "mongodb+srv://aiden:Wnsdud77!4@thai-carrots.llj9b.mongodb.net/?retryWrites=true&w=majority&appName=thai-carrots"
// import from other files
const authRouter = require('./routes/auth');

//middleware [Client -> Sever -> Client]
app.use(express.json()); // json parsing
app.use(authRouter);

//connections with mongo
mongoose.connect(DB).then(() =>{
  console.log("connection successful!")
}).catch((e) => {
  console.log(e);
})

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});