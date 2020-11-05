import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledLoginPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function LoginPage() {
  return <StyledLoginPage>LoginPage</StyledLoginPage>;
}

export default hot(module)(LoginPage);
