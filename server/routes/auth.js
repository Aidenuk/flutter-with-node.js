const express = require('express')
const User = require("../models/user")
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const authRouter = express.Router();
const auth = require("../middlewares/auth");

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
    const token = jwt.sign({id: user._id}, "passwordkey");
    res.json({token, ...user._doc});

  }catch(e){
    res.status(500).json({error:e.message });

  }
})

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;