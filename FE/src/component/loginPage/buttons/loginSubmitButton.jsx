import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";
import axiosApi from "../../../util/axiosApi";

const StyledSubmitButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function SubmitButton(props) {
  const onSubmitAction = async () => {
    const data = { user_id: props.inputData.name, password: props.inputData.password };
    const res = await axiosApi("/auth/login", "POST", data);
    if (res.data.state === "success") {
      props.setUser({ id: 1, name: data.user_id, url: "test" });
      localStorage.setItem("token", res.data.JWT);
    } else {
      alert("아이디 비밀번호를 확인해주세요");
    }
  };
  return (
    <Link to="./">
      <StyledSubmitButton onClick={onSubmitAction}>로그인 하기 </StyledSubmitButton>
    </Link>
  );
}
export default hot(module)(SubmitButton);
