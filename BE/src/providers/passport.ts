import passport from "passport";
import passportLocal from "passport-local";

const LocalStrategy = passportLocal.Strategy;

class Passport {
  public config = () => {
    // Local Strategy
    passport.use(
      new LocalStrategy(
        {
          usernameField: "userID",
          passwordField: "password",
        },
        async (userId: string, passWord: string, done) => {
          const user = { userID: userId, password: passWord };
          return done(null, user, { message: "Logged In Successfully" });
        }
      )
    );

    passport.serializeUser<unknown, unknown>((user, done) => {
      done(null, user);
    });

    passport.deserializeUser((user, done) => {
      done(null, user);
    });
  };
}

export default Passport;
