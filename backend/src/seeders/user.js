import { User } from "../models/user.model.js";
import { faker } from "@faker-js/faker";
import { ApiError } from "../utils/ApiError.js";

const createUser = async (numUsers) => {
  try {
    const usersPromise = [];
    for (let i = 0; i < numUsers; i++) {
      const tempUser = await User.create({
        fullName: faker.person.fullName(),
        enail: faker.internet.email(),
        username: faker.internet.userName(),
        gender: faker.person.gender(),
        dateOfBirth: faker.person.dateOfBirth(),
        avatar: "./public/temp/user.png",
        password: "password",
      });
      console.log(tempUser);
      usersPromise.push(tempUser);
    }
    await Promise.all(usersPromise);
    console.log("Users created", numUsers);
    return usersPromise;
  } catch (error) {
    new ApiError(400, "Unable to create users", error);
  }
};

export { createUser };
