import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledHeader = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function Header() {
  return <StyledHeader>Header</StyledHeader>;
}

export default hot(module)(Header);
