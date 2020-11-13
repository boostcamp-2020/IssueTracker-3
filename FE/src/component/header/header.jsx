import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledHeader = styled.div`
  display: flex;
  background-color: dimgrey;
  color: white;
  height: 10%;
  margin: 0px;
  font-weight: bold;
  justify-content: center;
  align-items: center;
`;
function Header() {
  return <StyledHeader>🔥IssueTracker🔥</StyledHeader>;
}

export default hot(module)(Header);
