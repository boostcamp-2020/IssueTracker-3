import passport from "passport";
import passportLocal from "passport-local";
import passportGithub from "passport-github";

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
          clientID: "d20e11f7575f75de3e43",
          clientSecret: "92cef0a81b7e187eb00b2a07e90846311c987f26",
          callbackURL: "http://127.0.0.1:3000/auth/github/callback",
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
