import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import LoginSubmitButton from "../component/loginPage/buttons/loginSubmitButton";
import LoginGithubButton from "../component/loginPage/buttons/loginGithubButton";
import LoginFrom from "../component/loginPage/form/loginform";

const StyledLoginPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function LoginPage() {
  return (
    <StyledLoginPage>
      LoginPage
      <LoginFrom />
      <LoginSubmitButton />
      <LoginGithubButton />
    </StyledLoginPage>
  );
}

export default hot(module)(LoginPage);
