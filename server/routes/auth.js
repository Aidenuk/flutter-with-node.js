const express = require('express')
const User = require("../models/user")
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const authRouter = express.Router();
const auth = require("../middlewares/auth");
const mongoose = require('mongoose');
//SIGN UP 
authRouter.post('/api/signup', async (req,res) =>{
  try{
    //get the data from the user
  const {name,email,password} = req.body;
  //check validation from DB
  const existingUser = await User.findOne({email}); // 중복되는 이메일이 있는지 스키마를 이용해서 db체크 
  if(existingUser) {
    return res.status(400).json({msg: "the email is already registered"});
  } //make it stop by returning 400 error
  const hasedPassword = await bcryptjs.hash(password,8);
  // post that data in db
  let user = new User({
    name,
    email,
    password: hasedPassword,
  }) // the order does not matter
   
  // return that data to the user
  user = await user.save();
  res.json(user);

  } catch(e){
    res.status(500).json({error: e.message});
  }

})

//SIGN IN [DB에 저장된 해쉬비밀번호 키값과 비교하는 것이 키포인트]
authRouter.post('/api/signin', async(req,res) =>{
  try{
    const {email,password} = req.body;
    const user = await User.findOne({email});
    if(!user){
      return res.status(400).json({msg: "the email does not exist!"})
    }
    //입력한 이메일이 있다면 이제 비밀번호를 비교
    const isMatch = await bcryptjs.compare(password, user.password);
    if(!isMatch){
      return res.status(400).json({msg: "the password is wrong!"})
    }
    //입력한 비밀번호가 맞다면
    const token = jwt.sign({id: user._id}, "passwordKey");
    res.json({token, ...user._doc});

  }catch(e){
    res.status(500).json({error:e.message });

  }
})

authRouter.post("/tokenIsValid", async (req, res) => {

  try {
    const token = req.header("x-auth-token");
    if (!token) {
      console.error("Token is missing");
      return res.json(false);
    }
    console.log("Token received:", token);

    const verified = jwt.verify(token, "passwordKey");
    console.log("Verified payload:", verified);

    const user = await User.findById(verified.id);
    console.log("User object:", user);
    if (!user) {
      console.error("User not found for ID:", verified.id);
      return res.json(false);
    }
    res.json(true);
  } catch (e) {
    console.error("Error while fetching user:", e.message);
    res.status(500).json({ error: e.message });
  }
});
//Testing with browser
// authRouter.get("/", (req, res) => {
//   res.json({ msg: "Welcome to the API" });
// });
// get user data [it won't work for browser as it has no token header]
authRouter.get("/", auth, async (req, res) => {
  try{
    const user = await User.findById(req.user);
    console.log("successfully get user info:", user);
    if(!user){
      console.log("can not get user info",req.user);
      return res.json(false);
    }

  res.json({ ...user._doc, token: req.token });


  }catch(e){
    console.error("unable to get User info:", e.message);
    res.status(500).json({error:e.message});
  }
  
});

module.exports = authRouter;