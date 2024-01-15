const { loginController } = require("../controllers/login");

const res = {
    status: jest.fn(x => x),
    send: jest.fn(x => x),
};

it('should return login success', () => {
    const req = {
        body: {
            username: "admin",
            password: "admin"
        }
    };

    loginController(req, res);

    expect(res.send).toHaveBeenCalledWith('login success');
});

it('should return login fail', () => {
    const req = {
        body: {
            username: "admin",
            password: "admin1"
        }
    };

    loginController(req, res);

    expect(res.status).toHaveBeenCalledWith(401);
    expect(res.send).toHaveBeenCalledWith('login fail');
});