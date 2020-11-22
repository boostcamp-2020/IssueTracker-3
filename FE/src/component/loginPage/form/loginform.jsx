import React from "react";
import { hot } from "react-hot-loader";

const LoginForm = (props) => {
  const onNameHandler = (event) => {
    const name = event.target.value;
    const { password } = props.inputData;
    props.setInput({ name, password });
  };
  const onPasswordHandler = (event) => {
    const { name } = props.inputData;
    const password = event.target.value;
    props.setInput({ name, password });
  };
  return (
    <form>
      <label>아이디</label>
      <input type={Text} value={props.inputData.name} onChange={onNameHandler} />
      <label>비밀번호</label>
      <input type={Text} value={props.inputData.password} onChange={onPasswordHandler} />
    </form>
  );
};

export default hot(module)(LoginForm);
