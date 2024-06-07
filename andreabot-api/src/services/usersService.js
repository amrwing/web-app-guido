const User = require('../database/user');

const login = async (id) => {
    const getUser = await User.getUserById(id);
    return getUser;
};

module.exports = {
    login
}
