import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function Header() {
  return <StyledButton>Header</StyledButton>;
}

export default hot(module)(Header);
