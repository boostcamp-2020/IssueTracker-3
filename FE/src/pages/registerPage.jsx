import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledRegisterPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function RegisterPage() {
  return <StyledRegisterPage>RegisterPage</StyledRegisterPage>;
}

export default hot(module)(RegisterPage);
