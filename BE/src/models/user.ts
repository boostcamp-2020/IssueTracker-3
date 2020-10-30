import Model from "./model";

class UserModel extends Model {
  static async read(): Promise<any> {
    return new Promise((resolve, reject) => {
      try {
        resolve(1);
      } catch (err) {
        reject(err);
      }
    });
  }
}

export default UserModel;
