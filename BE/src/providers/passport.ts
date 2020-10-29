import passport from "passport";
import passportLocal from "passport-local";
import passportGithub from "passport-github";
import dotenv from "dotenv";
import path from "path";

dotenv.config({ path: path.join(__dirname, "../../.env") });

const LocalStrategy = passportLocal.Strategy;
const GithubStrategy = passportGithub.Strategy;
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
    //Github Strategy
    passport.use(
      new GithubStrategy(
        {
          clientID: process.env.GIT_ID as string,
          clientSecret: process.env.GIT_PASSWORD as string,
          callbackURL: process.env.GIT_CALLBACK as string,
        },
        async (accessToken, refreshToken, profile, cb) => {
          const user = profile;
          return cb(null, user);
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
