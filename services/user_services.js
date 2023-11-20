const UserModel = require("../models/user_model");
const jwt = require("jsonwebtoken");

class UserServices {
  static async registerUser(username, password, sharingpreference) {
    try {
      console.log(
        "-----Email --- Password-----Sharing Preference-----",
        username,
        password,
        sharingpreference
      );

      const createUser = new UserModel({
        username,
        password,
        sharingpreference,
      });
      return await createUser.save();
    } catch (err) {
      throw err;
    }
  }

  static async getUserByUsername(username) {
    try {
      return await UserModel.findOne({ username });
    } catch (err) {
      console.log(err);
    }
  }

  static async checkUser(username) {
    try {
      return await UserModel.findOne({ username });
    } catch (error) {
      throw error;
    }
  }

  static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
    return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
  }
}

module.exports = UserServices;
