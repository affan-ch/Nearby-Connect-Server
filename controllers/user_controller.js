const UserServices = require('../services/user_services');

exports.register = async (req, res, next) => 
{
    try {
        console.log("---req body---", req.body);
        const { username, password, sharingpreference} = req.body;
        const duplicate = await UserServices.getUserByUsername(username);
        if (duplicate) {
            throw new Error(`UserName ${username}, Already Registered`)
        }
        const response = await UserServices.registerUser(username, password,sharingpreference);

        res.json({ status: true, success: 'User registered successfully' });


    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}

exports.login = async (req, res, next) => {
    try {

        const { username, password } = req.body;

        if (!username || !password) {
            throw new Error('Parameter are not correct');
        }
        let user = await UserServices.checkUser(username);
        if (!user) {
            throw new Error('User does not exist');
        }

        const isPasswordCorrect = await user.comparePassword(password);

        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }

        // Creating Token

        let tokenData;
        tokenData = { _id: user._id, userName: user.username };
    

        const token = await UserServices.generateAccessToken(tokenData,"secret","1h")

        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}