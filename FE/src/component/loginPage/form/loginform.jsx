import React from "react";
import { hot } from "react-hot-loader";

const LoginForm = () => {
  return (
    <form>
      <label>아이디</label>
      <input type={Text} />
      <label>비밀번호</label>
      <input type={Text} />
    </form>
  );
};

export default hot(module)(LoginForm);
